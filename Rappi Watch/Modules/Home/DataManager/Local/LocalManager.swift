//
//  LocalManager.swift
//  Rappi Watch
//
//  Created by Bryan Caro on 11/12/21.
//

import Foundation

protocol LocalManagerProtocol {
    // MARK: - Movies
    func retrieveMoviesData(_ filter: FilterModel, completion: @escaping(ResponseTopMovies?) -> Void)
    
    // MARK: - TV Series
    func retrieveTVSeriesData(_ filter: FilterModel, completion: @escaping(TVSerieResponse?) -> Void)
    
    // MARK: - People
    func retrievePeopleData(_ filter: FilterModel, completion: @escaping(PeopleResponse?) -> Void)
}

final class LocalManager: LocalManagerProtocol {
    private let storage = DataStorage.shared
    
    func retrieveMoviesData(_ filter: FilterModel, completion: @escaping(ResponseTopMovies?) -> Void) {        
        let data = ResponseTopMovies(page: 1, results: storage.retrieveMoviesArray(filter: filter.filter.active), totalPages: 100, totalResults: 100)
        DispatchQueue.main.async {
            completion(data)
        }
    }
    
    func retrieveTVSeriesData(_ filter: FilterModel, completion: @escaping(TVSerieResponse?) -> Void) {
        let data = TVSerieResponse(page: 1, results: storage.retrieveTVSerieArray(filter: filter.filter.active), totalPages: 100, totalResults: 100)
        DispatchQueue.main.async {
            completion(data)
        }
    }
    
    func retrievePeopleData(_ filter: FilterModel, completion: @escaping(PeopleResponse?) -> Void) {
        let data = PeopleResponse(page: 1, results: storage.retrievePeoplesArray(filter: filter.filter.active), totalPages: 100, totalResults: 100)
        DispatchQueue.main.async {
            completion(data)
        }
    }
}
