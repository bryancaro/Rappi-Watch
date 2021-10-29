//
//  Movie.swift
//  Rappi Watch
//
//  Created by Bryan Caro on 10/28/21.
//

import Foundation

struct PopularRatedMovie {
    var page: Int
    var results: [Movie]
    var total_pages: Int
    var total_results: Int
}

struct Upcoming {
    var page: Int
    var results: [Movie]
    var dates: Dates
    var total_results: Int
    var total_pages: Int
}

struct Dates {
    let maximum: String
    let minimum: String
}

struct Movie {
    let poster_path: String?
    let adult: Bool
    let overview: String?
    let release_date: String
    let genre_ids: [Int]
    let id: Int
    let original_title: String
    let original_language: String
    let title: String
    let backdrop_path: String?
    let popularity: Double
    let vote_count: Int
    let video: Bool
    let vote_average: Double
}
