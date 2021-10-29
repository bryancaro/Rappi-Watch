//
//  TVSerie.swift
//  Rappi Watch
//
//  Created by Bryan Caro on 10/28/21.
//

import Foundation

struct TVSerieResponse {
    var page: Int
    var results: [Movie]
    var total_pages: Int
    var total_results: Int
}

struct TVSerie {
    let poster_path: String?
    let popularity: Double
    let id: Int
    let backdrop_path: String?
    let vote_average: Double
    let overview: String?
    let first_air_date: String
    let origin_country: [String]
    let genre_ids: [Int]
    let original_language: String
    let vote_count: Int
    let name: String
    let original_name: String
}
