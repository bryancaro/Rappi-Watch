//
//  HomeRepository.swift
//  Rappi Watch
//
//  Created by Bryan Caro on 10/30/21.
//

import Foundation

protocol HomeRepositoryProtocol {
    // MARK: - Movies
    func fetchPopularMovies(page: Int, completion: @escaping(ResponseTopMovies?, Error?) -> Void)
    func fetchTopRatedMovies(page: Int, completion: @escaping(ResponseTopMovies?, Error?) -> Void)
    func fetchUpComingMovies(page: Int, completion: @escaping(Upcoming?, Error?) -> Void)
    
    // MARK: - TV Series
    func fetchPopularTVSeries(page: Int, completion: @escaping(TVSerieResponse?, Error?) -> Void)
    func fetchTopRatedTVSeries(page: Int, completion: @escaping(TVSerieResponse?, Error?) -> Void)
}

class HomeRepository {
    private let server: ServerManager
    //    private let local  = UserLocalService()
    
    init(server: ServerManager = ServerManager()) {
        self.server = server
    }
}

extension HomeRepository: HomeRepositoryProtocol {
    // MARK: - Movies
    func fetchPopularMovies(page: Int, completion: @escaping(ResponseTopMovies?, Error?) -> Void) {
        server.fetchPopularMovies(page: page, completion: completion)
    }
    
    func fetchTopRatedMovies(page: Int, completion: @escaping(ResponseTopMovies?, Error?) -> Void) {
        server.fetchTopRatedMovies(page: page, completion: completion)
    }
    
    func fetchUpComingMovies(page: Int, completion: @escaping(Upcoming?, Error?) -> Void) {
        server.fetchUpComingMovies(page: page, completion: completion)
    }
    
    // MARK: - TV Series
    func fetchPopularTVSeries(page: Int, completion: @escaping(TVSerieResponse?, Error?) -> Void) {
        server.fetchPopularTVSeries(page: page, completion: completion)
    }
    
    func fetchTopRatedTVSeries(page: Int, completion: @escaping(TVSerieResponse?, Error?) -> Void) {
        server.fetchTopRatedTVSeries(page: page, completion: completion)
    }
}
