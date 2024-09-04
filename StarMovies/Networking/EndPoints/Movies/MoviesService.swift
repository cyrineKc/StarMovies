//
//  MoviesService.swift
//  StarMovies
//
//  Created by Cyrine Kchir on 04.09.24.
//

import Foundation
import Combine

protocol MoviesServiceProtocol {
    
    func getMovies()-> AnyPublisher<MoviesResult, APIError>
        
    
}

class MoviesService : MoviesServiceProtocol {
    
    let apiClient = URLSessionAPIClient<MoviesEndPoint>()
    
    
    func getMovies() -> AnyPublisher<MoviesResult, APIError> {
        return apiClient.request(.getMovies)
    }
    
    
}
