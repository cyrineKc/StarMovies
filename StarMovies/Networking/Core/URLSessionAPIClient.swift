//
//  URLSessionAPIClient.swift
//  StarMovies
//
//  Created by Cyrine Kchir on 04.09.24.
//

import Foundation
import Combine

protocol APIClient {
    associatedtype EndpointType: APIEndpoint
    func request<T: Decodable>(_ endpoint: EndpointType) -> AnyPublisher<T, APIError>
}

protocol URLSessionProtocol {
    func dataTaskPublisher(for urlRequest: URLRequest) -> URLSession.DataTaskPublisher
}

extension URLSession: URLSessionProtocol {}


class URLSessionAPIClient<EndpointType: APIEndpoint>: APIClient {
    
    var urlSession : URLSessionProtocol
    
    init(urlSession: URLSessionProtocol = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    func request<T>(_ endpoint: EndpointType) -> AnyPublisher<T, APIError> where T : Decodable {
        let url = endpoint.baseURL.appendingPathComponent(endpoint.path)
       
        var request = URLRequest(url: url)
              request.httpMethod = endpoint.method.rawValue
        /*request..queryItems = parameters?.map { (key, value) in
            URLQueryItem(name: key, value: value)
        }*/
        endpoint.headers?.forEach { request.addValue($0.value, forHTTPHeaderField: $0.key) }
        
        print(endpoint.headers)
        return urlSession.dataTaskPublisher(for: request)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                    throw APIError.failedRequest
                }
                return data
            }.decode(type: T.self, decoder: JSONDecoder())
            .mapError({ error-> APIError in
                guard let _ = error as? APIError else {
                    
                    print(error)
                    return APIError.decodingFailed
                }
                return APIError.customError(description: error
                    .localizedDescription)
            })
            .eraseToAnyPublisher()
    }
    
    
}
