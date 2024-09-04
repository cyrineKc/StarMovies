//
//  MoviesEndPoint.swift
//  StarMovies
//
//  Created by Cyrine Kchir on 04.09.24.
//

import Foundation

enum MoviesEndPoint: APIEndpoint {
   
    case getMovies
    
    var baseURL: URL {
        return URL(string: "https://www.omdbapi.com/?s=Batman&page=2&apikey=*********")!
    }
    
    var path: String {
        switch self {
        case .getMovies : return ""
        }
        
    }
    
    var method: HTTPMethod {
        switch self {
        case .getMovies: return .get
        }
    }
    
    var headers: [String : String]? {
        var headers: [String: String] = [:]
        headers["Content-Type"] = "application/json"
        return headers
    }
    
    var body: Data? {
        switch self {
        case .getMovies: break
        }
        return nil
    }
    
    var parameters: [String : String]? {
        switch self {
        case .getMovies: 
            return ["page": "6", "apikey": "942fc842", "s": "Batman" ]
        }
    }
    
    
}
