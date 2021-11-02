//
//  TVSerieDetail.swift
//  Rappi Watch
//
//  Created by Bryan Caro on 10/28/21.
//

import Foundation

// MARK: - TVSerieDetail
struct TVSerieDetail: Codable, Hashable {
    var createdBy: [CreatedBy]
    var genres: [Genre]
    var id: Int
    var networks: [Network]
    var numberOfEpisodes, numberOfSeasons: Int
    var productionCompanies: [ProductionCompany]
    var productionCountries: [ProductionCountry]
    var seasons: [Season]
    var status: String

    enum CodingKeys: String, CodingKey {
        case createdBy = "created_by"
        case genres
        case id
        case networks
        case numberOfEpisodes = "number_of_episodes"
        case numberOfSeasons = "number_of_seasons"
        case productionCompanies = "production_companies"
        case productionCountries = "production_countries"
        case seasons
        case status
    }
}

let emptyTVSerieDetail = TVSerieDetail(createdBy: [CreatedBy](), genres: [Genre](), id: 0, networks: [Network](), numberOfEpisodes: 0, numberOfSeasons: 0, productionCompanies: [ProductionCompany](), productionCountries: [ProductionCountry](), seasons: [Season](), status: "")

// MARK: - CreatedBy
struct CreatedBy: Codable, Hashable {
    var id: Int
    var creditID, name: String
    var gender: Int
    var profilePath: String?

    enum CodingKeys: String, CodingKey {
        case id
        case creditID = "credit_id"
        case name, gender
        case profilePath = "profile_path"
    }
}

// MARK: - Network
struct Network: Codable, Hashable {
    var name: String
    var id: Int
    var logoPath: String?
    var originCountry: String

    enum CodingKeys: String, CodingKey {
        case name, id
        case logoPath = "logo_path"
        case originCountry = "origin_country"
    }
}

// MARK: - Season
struct Season: Codable, Hashable {
    var airDate: String?
    var episodeCount, id: Int
    var name, overview: String?
    var posterPath: String?
    var seasonNumber: Int

    enum CodingKeys: String, CodingKey {
        case airDate = "air_date"
        case episodeCount = "episode_count"
        case id, name, overview
        case posterPath = "poster_path"
        case seasonNumber = "season_number"
    }
}
