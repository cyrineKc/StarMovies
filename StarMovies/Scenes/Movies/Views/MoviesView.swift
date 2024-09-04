//
//  MoviesView.swift
//  StarMovies
//
//  Created by Cyrine Kchir on 04.09.24.
//

import SwiftUI

struct MoviesView: View {
    
    @StateObject var moviesViewModel = MoviesViewModel(moviesService: MoviesService())
    
    var body: some View {
        List(moviesViewModel.moviesList) { movie in
            Text(movie.title)
        }.onAppear {
            moviesViewModel.fetchMovies()
        }
        /*List {
            ForEach(moviesViewModel.moviesList) { $movie in
                Text(movie.name)
            }
            /*.onAppear {
                moviesViewModel.fetchMovies()
            }*/
        
        }*/
    }
}
    
#Preview {
    MoviesView()
}
