//
//  MoviesViewModel.swift
//  StarMovies
//
//  Created by Cyrine Kchir on 04.09.24.
//

import Foundation
import Combine

class MoviesViewModel: ObservableObject {
    
    @Published var moviesList = [Movie]()
    @Published var cancellables = Set<AnyCancellable>()
    @Published var isCompleted = false
    var moviesService : MoviesServiceProtocol
    
    init(moviesService: MoviesServiceProtocol) {
            self.moviesService = moviesService
        }
    
    func fetchMovies() {
        moviesService.getMovies().receive(on: RunLoop.main).sink { [weak self] completion in
            switch completion {
            case .finished:
                self?.isCompleted = true
            case .failure(let error):
                print(error)
            }
        } receiveValue: { [weak self] moviesResult in
            self?.moviesList = moviesResult.search
            print(self?.moviesList.count)
        }.store(in: &cancellables)

    }
    
}
