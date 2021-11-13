//
//  HomeRepository.swift
//  Rappi Watch
//
//  Created by Bryan Caro on 10/30/21.
//

import Foundation

protocol HomeRepositoryProtocol {
    // MARK: - Movies
    func fetchMovies(_ filter: FilterModel, _ category: CategoriesModel, page: Int, completion: @escaping(ResponseTopMovies?, ServerError?) -> Void)
    
    // MARK: - TV Series
    func fetchTVSeries(_ filter: FilterModel, _ category: CategoriesModel, page: Int, completion: @escaping(TVSerieResponse?, ServerError?) -> Void)
    
    // MARK: - People
    func fetchPeople(_ filter: FilterModel, _ category: CategoriesModel, page: Int, completion: @escaping(PeopleResponse?, ServerError?) -> Void)
}

class HomeRepository {
    private let server: ServerManager
    private let local : LocalManager
    private let reachability = ReachabilityManager()
    
    init(server: ServerManager = ServerManager(), local: LocalManager = LocalManager()) {
        self.server = server
        self.local = local
    }
}

extension HomeRepository: HomeRepositoryProtocol {
    // MARK: - Movies
    func fetchMovies(_ filter: FilterModel, _ category: CategoriesModel, page: Int, completion: @escaping(ResponseTopMovies?, ServerError?) -> Void) {
        if reachability.isConnected() {
            server.fetchMovies(filter, category, page: page, completion: completion)
        } else {
            local.retrieveMoviesData(filter) { response in
                DispatchQueue.main.async {
                    completion(response, nil)
                }
            }
        }
    }
    
    // MARK: - TV Series
    func fetchTVSeries(_ filter: FilterModel, _ category: CategoriesModel, page: Int, completion: @escaping(TVSerieResponse?, ServerError?) -> Void) {
        if reachability.isConnected() {
            server.fetchTVSeries(filter, category, page: page, completion: completion)
        } else {
            local.retrieveTVSeriesData(filter) { response in
                DispatchQueue.main.async {
                    completion(response, nil)
                }
            }
        }
    }
    
    // MARK: - People
    func fetchPeople(_ filter: FilterModel, _ category: CategoriesModel, page: Int, completion: @escaping(PeopleResponse?, ServerError?) -> Void) {
        if reachability.isConnected() {
            server.fetchPeople(filter, category, page: page, completion: completion)
        } else {
            local.retrievePeopleData(filter) { response in
                DispatchQueue.main.async {
                    completion(response, nil)
                }
            }
        }
    }
}
