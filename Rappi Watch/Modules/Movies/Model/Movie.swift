//
//  Movie.swift
//  Rappi Watch
//
//  Created by Bryan Caro on 10/28/21.
//

import Foundation

struct PopularRatedMovie: Decodable {
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

struct Movie: Decodable, Hashable {
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
    var popularity: Double
    var vote_count: Int
    let video: Bool
    var vote_average: Double
}

let emptyMovie = Movie(poster_path: nil, adult: false, overview: nil, release_date: "", genre_ids: [Int](), id: 0, original_title: "", original_language: "", title: "", backdrop_path: nil, popularity: 0, vote_count: 0, video: false, vote_average: 0)
