//
//  TVSerie.swift
//  Rappi Watch
//
//  Created by Bryan Caro on 10/28/21.
//

import Foundation

// MARK: - TVSerieResponse
struct TVSerieResponse: Codable, Hashable {
    var page: Int
    var results: [TVSerie]
    var totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - TVSerie
struct TVSerie: Codable, Hashable {
    var firstAirDate: String
    var id: Int
    var name: String
    var overview: String
    var popularity: Double
    var posterPath: String?
    var voteAverage: Double
    var voteCount: Int

    enum CodingKeys: String, CodingKey {
        case firstAirDate = "first_air_date"
        case id, name
        case overview, popularity
        case posterPath = "poster_path"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

let emptyTVSerie = TVSerie(firstAirDate: "", id: 0, name: "", overview: "", popularity: 0, posterPath: "", voteAverage: 0, voteCount: 0)
