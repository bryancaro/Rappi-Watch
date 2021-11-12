//
//  HomeRepository.swift
//  Rappi Watch
//
//  Created by Bryan Caro on 10/30/21.
//

import Foundation

protocol HomeRepositoryProtocol {
    // MARK: - Movies
    func fetchMovies(_ filter: FilterModel, page: Int, completion: @escaping(ResponseTopMovies?, ServerError?) -> Void)
    
    // MARK: - TV Series
    func fetchTVSeries(_ filter: FilterModel, page: Int, completion: @escaping(TVSerieResponse?, ServerError?) -> Void)
}

class HomeRepository {
    private let server: ServerManager
    
    init(server: ServerManager = ServerManager()) {
        self.server = server
    }
}

extension HomeRepository: HomeRepositoryProtocol {
    // MARK: - Movies
    func fetchMovies(_ filter: FilterModel, page: Int, completion: @escaping(ResponseTopMovies?, ServerError?) -> Void) {
        server.fetchMovies(filter, page: page, completion: completion)
    }
    
    func fetchTVSeries(_ filter: FilterModel, page: Int, completion: @escaping(TVSerieResponse?, ServerError?) -> Void) {
        server.fetchTVSeries(filter, page: page, completion: completion)
    }
}
