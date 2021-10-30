//
//  MovieRepository.swift
//  Rappi Watch
//
//  Created by Bryan Caro on 10/30/21.
//

import Foundation

protocol MovieRepositoryProtocol {
    func fetchMovieDetail(id: Int, completion: @escaping(MovieDetail?, Error?) -> Void)
}

class MovieRepository {
    private let server: ServerManager
    //    private let local  = UserLocalService()
    
    init(server: ServerManager = ServerManager()) {
        self.server = server
    }
}

extension MovieRepository: MovieRepositoryProtocol {
    func fetchMovieDetail(id: Int, completion: @escaping(MovieDetail?, Error?) -> Void) {
        server.fetchMovieDetail(id: id, completion: completion)
    }
}
