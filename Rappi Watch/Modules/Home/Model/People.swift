//
//  People.swift
//  Rappi Watch
//
//  Created by Bryan Caro on 11/12/21.
//

import Foundation

// MARK: - People
struct PeopleResponse: Codable, Hashable {
    let page: Int
    let results: [People]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result
struct People: Codable, Hashable {
    let adult: Bool
    let gender, id: Int
    var knownFor: [KnownFor]
    let knownForDepartment: KnownForDepartment
    let name: String
    let popularity: Double
    let profilePath: String?

    enum CodingKeys: String, CodingKey {
        case adult, gender, id
        case knownFor = "known_for"
        case knownForDepartment = "known_for_department"
        case name, popularity
        case profilePath = "profile_path"
    }
}

// MARK: - KnownFor
struct KnownFor: Codable, Hashable {
    let adult: Bool?
    let backdropPath: String?
    let genreIDS: [Int]
    let id: Int
    let mediaType: MediaType
//    let originalLanguage: OriginalLanguage
    let originalTitle: String?
    let overview, posterPath: String?
    let releaseDate, title: String?
    let video: Bool?
    let voteAverage: Double
    let voteCount: Int
    let firstAirDate, name: String?
//    let originCountry: [String]?
    let originalName: String?

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case mediaType = "media_type"
//        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case firstAirDate = "first_air_date"
        case name
//        case originCountry = "origin_country"
        case originalName = "original_name"
    }
}

enum MediaType: String, Codable, Hashable {
    case movie = "movie"
    case tv = "tv"
}

//enum OriginalLanguage: String, Codable, Hashable {
//    case cn = "cn"
//    case en = "en"
//    case hi = "hi"
//    case ja = "ja"
//    case uk = "uk"
//    case zh = "zh"
//}

enum KnownForDepartment: String, Codable {
    case acting = "Acting"
}
