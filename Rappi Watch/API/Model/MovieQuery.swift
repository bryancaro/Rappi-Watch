//
//  MovieQuery.swift
//  Rappi Watch
//
//  Created by Bryan Caro on 11/13/21.
//

import Foundation

struct MovieQuery: Encodable, Decodable, Hashable {
    var api_key: String
    var language: String
    var page: Int
}
