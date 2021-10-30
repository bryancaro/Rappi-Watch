//
//  MovieDetail.swift
//  Rappi Watch
//
//  Created by Bryan Caro on 10/28/21.
//

import Foundation

struct MovieDetail: Decodable, Hashable {
    let id: Int
    let adult: Bool
    let backdrop_path: String?
    var budget: Int
    let genres: [Genres]
    let original_language: String
    let original_title: String
    let overview: String?
    var popularity: Double
    let poster_path: String?
    var production_companies: [ProductionCompanies]
    var production_countries: [ProductionCountries]
    let release_date: String
    var revenue: Int
    let runtime: Int?
    var spoken_languages: [SpokenLanguages]
    let status: String
    let title: String
    var vote_average: Double
    var vote_count: Int
}

let emptyMovieDetail = MovieDetail(id: 0, adult: false, backdrop_path: nil, budget: 0, genres: [Genres](), original_language: "", original_title: "", overview: nil, popularity: 0, poster_path: nil, production_companies: [ProductionCompanies](), production_countries: [ProductionCountries](), release_date: "", revenue: 0, runtime: nil, spoken_languages: [SpokenLanguages](), status: "", title: "", vote_average: 0, vote_count: 0)

struct Genres: Decodable, Hashable {
    let id: Int
    let name: String
}

struct ProductionCompanies: Decodable, Hashable {
    let name: String
    let id: Int
    let logo_path: String?
    let origin_country: String
}

struct ProductionCountries: Decodable, Hashable {
    let iso_3166_1: String
    let name: String
}

struct SpokenLanguages: Decodable, Hashable {
    let iso_639_1: String
    let name: String
}
