//
//  NetworkService.swift
//  SampleAppUsingViper
//
//  Created by Daniyal Yousuf on 2023-04-30.
//

import Foundation
import Combine

protocol NetworkServiceProtocol {
    func getData<T: Decodable>(endpoint: String,
                                                    queryParameters: [String: String]) -> AnyPublisher<[T], NetworkServiceError>
    func getCombine<T: Decodable>(endPoint: String,
                    bodyParams: [String: String]?,
                                  queryParams: [String: String]?) -> AnyPublisher<T, NetworkServiceError>
    func getSimple<T: Decodable>(endPoint: String,
                                   bodyParams: [String: String]?,
                                  queryParams: [String: String]?,  completion: ((Result<T,  NetworkServiceError>) ->Void)?)
    func getAsynAwait<T: Decodable>(endPoint: String,
                                    bodyParams: [String: String]?,
                                   queryParams: [String: String]?,  completion: ((Result<T,  NetworkServiceError>) ->Void)?) async
    func getAsynAwaitRet<T: Decodable>(endPoint: String,
                                    bodyParams: [String: String]?,
                                   queryParams: [String: String]?) async -> Result<T, NetworkServiceError>
}

struct NetworkService: NetworkServiceProtocol {
    let urlSession: URLSession
    let baseURLString: String
    
    init(urlSession: URLSession = .shared, baseURLString: String) {
        self.urlSession = urlSession
        self.baseURLString = baseURLString
    }
}

enum NetworkServiceError: Error {
    case invalidURL
    case decodingError(String)
    case genericError(String)
    case invalidResponseCode(Int)
    
    var errorMessageString: String {
        switch self {
        case .invalidURL:
            return "Invalid URL encountered. Can't proceed with the request"
        case .decodingError:
            return "Encountered an error while decoding incoming server response. The data couldn’t be read because it isn’t in the correct format."
        case .genericError(let message):
            return message
        case .invalidResponseCode(let responseCode):
            return "Invalid response code encountered from the server. Expected 200, received \(responseCode)"
        }
    }
}
