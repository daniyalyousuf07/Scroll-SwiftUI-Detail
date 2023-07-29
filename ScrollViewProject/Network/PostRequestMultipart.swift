//
//  PostRequestMultipart.swift
//  MVVM-Nhal
//
//  Created by Daniyal Yousuf on 2023-06-19.
//

import Foundation
import Combine

//https://orjpap.github.io/swift/http/ios/urlsession/2021/04/26/Multipart-Form-Requests.html
extension NetworkService {
    struct ImageUploadModel {
        var fileName: String
        var fieldName: String
        var boundary: String = UUID().uuidString
        var mimeType: String
        var data: Data
    }
    
}

extension NetworkService {
    func uploadImage<T:Decodable>(imageData: ImageUploadModel,
                                  endPoint: String) ->  AnyPublisher<T, NetworkServiceError> {
       let boundary = UUID().uuidString
       var httpBody = NSMutableData()
        let data = imageData
        addDataField(httpBody: httpBody,
                     named: data.fileName,
                     data: data.data,
                     mimeType: data.mimeType,
                     boundary: boundary)
        
        let url = URL(string: baseURLString + endPoint)!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        httpBody.append("--\(boundary)--")
        request.httpBody = httpBody as Data
        
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
    
    func addDataField(httpBody: NSMutableData,
                      named name: String,
                      data: Data,
                      mimeType: String, boundary: String) {
        httpBody.append(dataFormField(named: name,
                                      data: data, mimeType: mimeType,
                                      boundary: boundary))
    }
    
    
    private func dataFormField(named name: String,
                               data: Data,
                               mimeType: String,
                               boundary: String) -> Data {
        
        let fieldData = NSMutableData()
        
        fieldData.append("--\(boundary)\r\n")
        fieldData.append("Content-Disposition: form-data; name=\"\(name)\"\r\n")
        fieldData.append("Content-Type: \(mimeType)\r\n")
        fieldData.append("\r\n")
        fieldData.append(data)
        fieldData.append("\r\n")
        
        return fieldData as Data
    }
}

extension NSMutableData {
    func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            self.append(data)
        }
    }
}
