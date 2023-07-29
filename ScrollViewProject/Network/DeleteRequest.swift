//
//  DeleteRequest.swift
//  MVVM-Nhal
//
//  Created by MuhammadNihal on 5/23/23.
//

import Foundation
import Combine

extension NetworkService {
    func deleteRequest<T: Decodable>(endPoint: String,
                     params: [String: String],
                     token: String? = nil) -> AnyPublisher<T, NetworkServiceError> {
        
        guard let url = URL(string: "https://api.thecatapi.com/v1/breeds" + endPoint) else {
            fatalError("Invalid URL")
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        if let token = token {
            var headers = [String: String]()
            headers["Authorization"]  = "Bearer" + token
            request.allHTTPHeaderFields = headers
        }

        let encoder = JSONEncoder()
        guard let encodedData = try? encoder.encode(params) else {
            fatalError("Failed to encode request data")
        }
        
        // Set the request body
        request.httpBody = encodedData
        
        return urlSession.dataTaskPublisher(for: request)
            .tryMap { (data, response) -> Data in
                if let httpResponse = response as? HTTPURLResponse {
                    guard (200..<300) ~= httpResponse.statusCode else {
                        throw NetworkServiceError.invalidResponseCode(httpResponse.statusCode)
                    }
                }
                return data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error -> NetworkServiceError in
                if let decodingError = error as? DecodingError {
                    return NetworkServiceError.decodingError((decodingError as NSError).debugDescription)
                }
                return NetworkServiceError.genericError(error.localizedDescription)
            }
            .eraseToAnyPublisher()
        
    }
    
}
