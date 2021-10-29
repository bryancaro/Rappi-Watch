//
//  TVSerieDetail.swift
//  Rappi Watch
//
//  Created by Bryan Caro on 10/28/21.
//

import Foundation

struct TVSerieDetail {
    let backdrop_path: String?
    let created_by: [CreatedBy]
    let episode_run_time: [Int]
    let first_air_date: String
    let genres: [Genres]
    let homepage: String
    let id: Int
    let in_production: Bool
    let languages: [String]
    let last_air_date: String
    let last_episode_to_air: LastEpisodeToAir
    let name: String
    let next_episode_to_air: String?
    let networks: [Networks]
    let number_of_episodes: Int
    let number_of_seasons: Int
    let origin_country: [String]
    let original_language: String
    let original_name: String
    let overview: String
    let popularity: Double
    let poster_path: String?
    let production_companies: [ProductionCompanies]
    let production_countries: [ProductionCountries]
    let seasons: [Seasons]
    let spoken_languages: [SpokenLanguages]
    let status: String
    let tagline: String
    let type: String
    let vote_average: Double
    let vote_count: Int
}

struct CreatedBy {
    let id: Int
    let credit_id: String
    let name: String
    let gender: Int
    let profile_path: String?
}

struct LastEpisodeToAir {
    let air_date: String
    let episode_number: Int
    let id: Int
    let name: String
    let overview: String
    let production_code: String
    let season_number: Int
    let still_path: String?
    let vote_average: Double
    let vote_count: Int
}

struct Networks {
    let name: String
    let id: Int
    let logo_path: String?
    let origin_country: String
}

struct Seasons {
    let air_date: String
    let episode_count: Int
    let id: Int
    let name: String
    let overview: String
    let poster_path: String
    let season_number: Int
}
