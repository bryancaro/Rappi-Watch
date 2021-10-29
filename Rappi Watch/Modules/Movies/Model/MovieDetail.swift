//
//  MovieDetail.swift
//  Rappi Watch
//
//  Created by Bryan Caro on 10/28/21.
//

import Foundation

struct MovieDetail {
    let id: Int
    let adult: Bool
    let backdrop_path: String?
    let budget: Int
    let genres: [Genres]
    let original_language: String
    let original_title: String
    let overview: String?
    let popularity: Double
    let poster_path: String?
    let production_companies: [ProductionCompanies]
    let production_countries: [ProductionCountries]
    let release_date: String
    let revenue: Int
    let runtime: Int?
    let spoken_languages: [SpokenLanguages]
    let status: String
    let title: String
    let vote_average: Double
    let vote_count: Int
}

struct Genres {
    let id: Int
    let name: String
}

struct ProductionCompanies {
    let name: String
    let id: Int
    let logo_path: String?
    let origin_country: String
}

struct ProductionCountries {
    let iso_3166_1: String
    let name: String
}

struct SpokenLanguages {
    let iso_639_1: String
    let name: String
}
