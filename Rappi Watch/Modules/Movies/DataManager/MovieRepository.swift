//
//  MovieRepository.swift
//  Rappi Watch
//
//  Created by Bryan Caro on 10/30/21.
//

import Foundation

protocol MovieRepositoryProtocol {
    func fetchMovieDetail(id: Int, completion: @escaping(MovieDetail?, ServerError?) -> Void)
}

class MovieRepository {
    private let server: ServerManager
    
    init(server: ServerManager = ServerManager()) {
        self.server = server
    }
}

extension MovieRepository: MovieRepositoryProtocol {
    func fetchMovieDetail(id: Int, completion: @escaping(MovieDetail?, ServerError?) -> Void) {
        server.fetchMovieDetail(id: id, completion: completion)
    }
}
