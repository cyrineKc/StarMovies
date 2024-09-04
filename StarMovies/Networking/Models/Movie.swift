//
//  Movie.swift
//  StarMovies
//
//  Created by Cyrine Kchir on 04.09.24.
//

import Foundation

struct MoviesResult: Decodable {
    let search: [Movie]
    private enum CodingKeys: String, CodingKey {
        case search = "Search"
    }
    
}

struct Movie: Decodable, Identifiable {
    let title : String
    let year: String
    let imdbId: String
    let poster: URL?
    
    var id: String {
        imdbId
    }
    
    private enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case imdbId = "imdbID"
        case poster = "Poster"
    }
}