//
//  HomeRepository.swift
//  Rappi Watch
//
//  Created by Bryan Caro on 10/30/21.
//

import Foundation

protocol HomeRepositoryProtocol {
    // MARK: - Movies
    func fetchPopularMovies(page: Int, completion: @escaping(ResponseTopMovies?, ServerError?) -> Void)
    func fetchTopRatedMovies(page: Int, completion: @escaping(ResponseTopMovies?, ServerError?) -> Void)
    func fetchUpComingMovies(page: Int, completion: @escaping(Upcoming?, ServerError?) -> Void)
    
    // MARK: - TV Series
    func fetchPopularTVSeries(page: Int, completion: @escaping(TVSerieResponse?, ServerError?) -> Void)
    func fetchTopRatedTVSeries(page: Int, completion: @escaping(TVSerieResponse?, ServerError?) -> Void)
}

class HomeRepository {
    private let server: ServerManager
    
    init(server: ServerManager = ServerManager()) {
        self.server = server
    }
}

extension HomeRepository: HomeRepositoryProtocol {
    // MARK: - Movies
    func fetchPopularMovies(page: Int, completion: @escaping(ResponseTopMovies?, ServerError?) -> Void) {
        server.fetchPopularMovies(page: page, completion: completion)
    }
    
    func fetchTopRatedMovies(page: Int, completion: @escaping(ResponseTopMovies?, ServerError?) -> Void) {
        server.fetchTopRatedMovies(page: page, completion: completion)
    }
    
    func fetchUpComingMovies(page: Int, completion: @escaping(Upcoming?, ServerError?) -> Void) {
        server.fetchUpComingMovies(page: page, completion: completion)
    }
    
    // MARK: - TV Series
    func fetchPopularTVSeries(page: Int, completion: @escaping(TVSerieResponse?, ServerError?) -> Void) {
        server.fetchPopularTVSeries(page: page, completion: completion)
    }
    
    func fetchTopRatedTVSeries(page: Int, completion: @escaping(TVSerieResponse?, ServerError?) -> Void) {
        server.fetchTopRatedTVSeries(page: page, completion: completion)
    }
}
