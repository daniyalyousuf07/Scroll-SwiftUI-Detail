//
//  GetRequest.swift
//  MVVM-Nhal
//
//  Created by Daniyal Yousuf on 2023-05-22.
//

import Foundation
import Combine

//MARK: - Get Request Network Service
extension NetworkService {
    func getData<T: Decodable>(endpoint: String,
                               queryParameters: [String: String]) -> AnyPublisher<T, NetworkServiceError> {
        
        let queryItems = queryParameters.map { URLQueryItem(name: $0, value: $1) }
        
        let urlComponents = NSURLComponents(string: baseURLString + endpoint)
        urlComponents?.queryItems = queryItems
        
        guard let url = urlComponents?.url else {
            return Fail(error: NetworkServiceError.invalidURL).eraseToAnyPublisher()
        }
        
        return urlSession.dataTaskPublisher(for: url)
            .tryMap { (data, response) -> Data in
                if let httpResponse = response as? HTTPURLResponse {
                    guard (200..<300) ~= httpResponse.statusCode else {
                        throw NetworkServiceError.invalidResponseCode(httpResponse.statusCode)
                    }
                }
                return data
            }
            .receive(on: DispatchQueue.main)
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error -> NetworkServiceError in
                if let decodingError = error as? DecodingError {
                    return NetworkServiceError.decodingError((decodingError as NSError).debugDescription)
                }
                return NetworkServiceError.genericError(error.localizedDescription)
            }
            .eraseToAnyPublisher()
    }
    
    
    func getA<T: Decodable>(endPoint: String, parameters: [String: String]) -> AnyPublisher<T, NetworkServiceError> {
        
        let queryItems = parameters.map{ URLQueryItem(name: $0, value: $1) }
        let urlComponents = NSURLComponents(string: baseURLString + endPoint)
        urlComponents?.queryItems = queryItems
        
        guard let url = urlComponents?.url else { return  Fail(error: NetworkServiceError.invalidURL).eraseToAnyPublisher() }
        
        
        var  request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("", forHTTPHeaderField: "")
        
        var header  = [String: String]()
        header["auttho"] = "Bearer"  + "toke"
        request.allHTTPHeaderFields = header
        
        let encoder = JSONEncoder()
        guard  let encodedData = try? encoder.encode(parameters)  else {
            return Fail(error: NetworkServiceError.decodingError("da")).eraseToAnyPublisher()
        }
        
        request.httpBody = encodedData
        
        return urlSession.dataTaskPublisher(for: url)
            .tryMap({ (data, response) -> Data in
                if let httpResponse = response as? HTTPURLResponse {
                    guard (200...300) ~= httpResponse.statusCode else {
                        throw NetworkServiceError.invalidResponseCode(httpResponse.statusCode)
                    }
                }
                return data
            })
            .receive(on: DispatchQueue.main)
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error -> NetworkServiceError in
                if let decodingError = error as? DecodingError {
                    return NetworkServiceError.decodingError((decodingError as NSError).debugDescription)
                }
                return NetworkServiceError.genericError(error.localizedDescription)
            }.eraseToAnyPublisher()
    }
}

//usingcombine
extension NetworkService {
    
    func getCombine<T: Decodable>(endPoint: String,
                    bodyParams: [String: String]? = nil,
                                  queryParams: [String: String]? = nil) -> AnyPublisher<T, NetworkServiceError> {
        
        var tokenValue: Bool = false
        
        guard let url = URL(string: baseURLString + endPoint) else {
            return Fail(error: NetworkServiceError.invalidURL).eraseToAnyPublisher()
        }
        
        var urlComponent = URLComponents(string: url.absoluteString)
        
        if let queryParams = queryParams {
            let queryItems = queryParams.map{ URLQueryItem(name: $0, value: $1) }
            urlComponent?.queryItems = queryItems
        }
        
        guard let url = urlComponent?.url else {
            return Fail(error: NetworkServiceError.invalidURL).eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if let bodyParams = bodyParams {
            let jsonEncoder = JSONEncoder()
            guard let data = try? jsonEncoder.encode(bodyParams) else {
                return Fail(error: NetworkServiceError.decodingError("_")).eraseToAnyPublisher()
            }
            
            //set data
            request.httpBody =  data
            
        }
        
        if tokenValue {
            var header = ["Authorization": "Bearer adasdasd123"]
            //set token
            request.allHTTPHeaderFields = header
        }
        
        return urlSession.dataTaskPublisher(for: request)
            .tryMap { (data, response) -> Data in
                if let response = response as? HTTPURLResponse, !((200...300) ~= response.statusCode) {
                    throw NetworkServiceError.invalidResponseCode(response.statusCode)
                }
                return data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .mapError { error -> NetworkServiceError in
                if let decodingError = error as? DecodingError {
                    return NetworkServiceError.decodingError((decodingError as  NSError).debugDescription)
                }
                return NetworkServiceError.genericError(error.localizedDescription)
            }.eraseToAnyPublisher()
    }
}

extension NetworkService {
    
    func  getSimple<T: Decodable>(endPoint: String,
                                   bodyParams: [String: String]? = nil,
                                  queryParams: [String: String]? = nil,  completion: ((Result<T,  NetworkServiceError>) ->Void)?  = nil)   {
        let tokenValue = false
        guard let _ = URL(string: baseURLString + endPoint) else {
            completion?(.failure(NetworkServiceError.invalidURL))
            return
        }
        
        var urlComponents = URLComponents(string: baseURLString + endPoint)
        
        if let queryParams =  queryParams {
            let queryItems = queryParams.map { URLQueryItem(name: $0, value: $1) }
            urlComponents?.queryItems = queryItems
        }
        
        guard let _ = urlComponents?.url else {
            completion?(.failure(NetworkServiceError.invalidURL))
            return
        }
        
        var request = URLRequest(url: urlComponents!.url!)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if let bodyParams = bodyParams {
            let jsonEncoder = JSONEncoder()
            if let data = try? jsonEncoder.encode(bodyParams) {
                request.httpBody = data
            } else {
                completion?(.failure(NetworkServiceError.decodingError("_")))
                return
            }
        }
        
        if tokenValue {
            request.allHTTPHeaderFields = ["Authorization" : "Bearer someValue"]
        }
        
        urlSession.dataTask(with: request) { data, response, error in
            if let error = error {
                completion?(.failure(NetworkServiceError.genericError(error.localizedDescription)))
                return
            }
           else if let response = response as? HTTPURLResponse, !((200...300) ~= response.statusCode) {
                completion?(.failure(NetworkServiceError.invalidResponseCode(response.statusCode)))
            }
           else if data == nil {
                completion?(.failure(.genericError("")))
            }
          else if let decodable = try? JSONDecoder().decode(T.self, from: data!) {
                completion?(.success(decodable))
            } else {
                completion?(.failure(.decodingError("Decoding Error")))
            }
        }.resume()
    }
}

extension NetworkService {
    func getAsynAwait<T: Decodable>(endPoint: String, bodyParams: [String : String]?, queryParams: [String : String]?,
                         completion: ((Result<T, NetworkServiceError>) -> Void)?) async {
        let tokenValue = false
        
        guard let _ = URL(string: baseURLString + endPoint) else {
            completion?(.failure(NetworkServiceError.invalidURL))
            return
        }

        var urlComponents = URLComponents(string: baseURLString + endPoint)
        
        if let queryParams =  queryParams {
            let queryItems = queryParams.map { URLQueryItem(name: $0, value: $1) }
            urlComponents?.queryItems = queryItems
        }
        
        guard let url = urlComponents?.url else {
            completion?(.failure(NetworkServiceError.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if let bodyParams = bodyParams {
            let jsonEncoder = JSONEncoder()
            if let data = try? jsonEncoder.encode(bodyParams) {
                request.httpBody = data
            } else {
                completion?(.failure(NetworkServiceError.decodingError("_")))
                return
            }
        }
        
        if tokenValue {
            request.allHTTPHeaderFields = ["Authorization" : "Bearer someValue"]
        }
        
        do {
            
            let result = try await urlSession.data(for: request)
           
            if let response = result.1 as? HTTPURLResponse, !((200...300) ~= response.statusCode) {
                completion?(.failure(NetworkServiceError.invalidResponseCode(response.statusCode)))
            }
            else if result.0.isEmpty {
                completion?(.failure(.genericError("")))
            }
           else if let decodable = try? JSONDecoder().decode(T.self, from: result.0) {
                completion?(.success(decodable))
            } else {
                completion?(.failure(.decodingError("Decoding Error")))
            }
        } catch {
            completion?(.failure(.genericError(error.localizedDescription)))
            return
        }
    }
}

extension NetworkService {
    func getAsynAwaitRet<T: Decodable>(endPoint: String, bodyParams: [String : String]?, queryParams: [String : String]?) async -> Result<T, NetworkServiceError> {
        let tokenValue = false
        
        guard let _ = URL(string: baseURLString + endPoint) else {
            return .failure(.invalidURL)
        }
        
        var urlComponents = URLComponents(string: baseURLString + endPoint)
        
        if let queryParams =  queryParams {
            let queryItems = queryParams.map { URLQueryItem(name: $0, value: $1) }
            urlComponents?.queryItems = queryItems
        }
        
        guard let url = urlComponents?.url else {
            return .failure(.invalidURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if let bodyParams = bodyParams {
            let jsonEncoder = JSONEncoder()
            if let data = try? jsonEncoder.encode(bodyParams) {
                request.httpBody = data
            } else {
                return .failure(.decodingError(""))
            }
        }
        
        if tokenValue {
            request.allHTTPHeaderFields = ["Authorization" : "Bearer someValue"]
        }
        
        do {
            
            let result = try await urlSession.data(for: request)
           
            if let response = result.1 as? HTTPURLResponse, !((200...300) ~= response.statusCode) {
                return .failure(.invalidResponseCode(response.statusCode))
            }
            if result.0.isEmpty {
                return .failure(.genericError(""))
            }
            if let decodable = try? JSONDecoder().decode(T.self, from: result.0) {
                return .success(decodable)
            } else {
                return .failure(.decodingError("Decoding Error"))
            }
        } catch {
            return .failure(.genericError(error.localizedDescription))
        }
    }
}
