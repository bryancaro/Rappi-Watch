//
//  MovieDetail.swift
//  Rappi Watch
//
//  Created by Bryan Caro on 10/28/21.
//

import Foundation

// MARK: - MovieDetail
struct MovieDetail: Codable, Hashable {
    var budget: Int
    var genres: [Genre]
    var id: Int
    var productionCompanies: [ProductionCompany]
    var productionCountries: [ProductionCountry]
    var revenue: Int
    var status: String

    enum CodingKeys: String, CodingKey {
        case budget, genres, id
        case productionCompanies = "production_companies"
        case productionCountries = "production_countries"
        case revenue
        case status
    }
}

let emptyMovieDetail = MovieDetail(budget: 0, genres: [Genre](), id: 0, productionCompanies: [ProductionCompany](), productionCountries: [ProductionCountry](), revenue: 0, status: "")

// MARK: - Genre
struct Genre: Codable, Hashable {
    var id: Int
    var name: String
}

// MARK: - ProductionCompany
struct ProductionCompany: Codable, Hashable {
    var id: Int
    var logoPath: String?
    var name, originCountry: String

    enum CodingKeys: String, CodingKey {
        case id
        case logoPath = "logo_path"
        case name
        case originCountry = "origin_country"
    }
}

// MARK: - ProductionCountry
struct ProductionCountry: Codable, Hashable {
    var iso3166_1, name: String

    enum CodingKeys: String, CodingKey {
        case iso3166_1 = "iso_3166_1"
        case name
    }
}
