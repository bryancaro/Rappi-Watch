//
//  Movie.swift
//  Rappi Watch
//
//  Created by Bryan Caro on 10/28/21.
//

import Foundation

// MARK: - ResponseTopMovies
struct ResponseTopMovies: Codable, Hashable {
    var page: Int
    var results: [Movie]
    var totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Movie
struct Movie: Codable, Hashable {
    var adult: Bool
    var id: Int
    var overview: String
    var popularity: Double
    var posterPath: String?
    var releaseDate, title: String
    var voteAverage: Double
    var voteCount: Int

    enum CodingKeys: String, CodingKey {
        case adult
        case id
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

let emptyMovie = Movie(adult: false, id: 0, overview: "", popularity: 0, posterPath: "", releaseDate: "", title: "", voteAverage: 0, voteCount: 0)

// MARK: - Upcoming
struct Upcoming: Codable, Hashable {
    var dates: Dates
    var page: Int
    var results: [Movie]
    var totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case dates, page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Dates
struct Dates: Codable, Hashable {
    var maximum, minimum: String
}
