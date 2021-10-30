//
//  HomeRepository.swift
//  Rappi Watch
//
//  Created by Bryan Caro on 10/30/21.
//

import Foundation

protocol HomeRepositoryProtocol {
    func fetchPopularMovies(page: Int, completion: @escaping(PopularRatedMovie?, Error?) -> Void)
}

class HomeRepository {
    private let server: ServerManager
    //    private let local  = UserLocalService()
    
    init(server: ServerManager = ServerManager()) {
        self.server = server
    }
}

extension HomeRepository: HomeRepositoryProtocol {
    func fetchPopularMovies(page: Int, completion: @escaping(PopularRatedMovie?, Error?) -> Void) {
        server.fetchPopularMovies(page: page, completion: completion)
    }
}
