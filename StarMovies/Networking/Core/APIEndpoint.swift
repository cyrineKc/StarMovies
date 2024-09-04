//
//  APIEndpoint.swift
//  StarMovies
//
//  Created by Cyrine Kchir on 04.09.24.
//

import Foundation


protocol APIEndpoint {
    
    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
    var body: Data? { get }
    var parameters: [String: String]? { get }
}


enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

enum APIError: LocalizedError {
    case failedRequest
    case decodingFailed
    case customError(description: String)
}
