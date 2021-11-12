//
//  ServerManager.swift
//  Rappi Watch
//
//  Created by Bryan Caro on 10/29/21.
//

import Foundation
import Alamofire

protocol ServerManagerProtocol {
    // MARK: - Movies
    func fetchMovies(_ filter: FilterModel, page: Int, completion: @escaping(ResponseTopMovies?, ServerError?) -> Void)
    func fetchMovieDetail(id: Int, completion: @escaping(MovieDetail?, ServerError?) -> Void)
    
    // MARK: - TV Series
    func fetchTVSeries(_ filter: FilterModel, page: Int, completion: @escaping(TVSerieResponse?, ServerError?) -> Void)
    func fetchTVSerieDetail(id: Int, completion: @escaping(TVSerieDetail?, ServerError?) -> Void)
}

struct MovieQuery: Encodable, Decodable, Hashable {
    var api_key: String
    var language: String
    var page: Int
}

final class ServerManager: ServerManagerProtocol {
    // MARK: - Properties
    private let reachability = ReachabilityManager()
    // MARK: - Movies
    func fetchMovies(_ filter: FilterModel, page: Int, completion: @escaping(ResponseTopMovies?, ServerError?) -> Void) {
        let url = "\(ConfigReader.baseUrl())/movie\(filter.filter.endpoint)"
        
        let parameters = MovieQuery(
            api_key: ConfigReader.apiKey(),
            language: "en-US",
            page: page
        )
        
        if reachability.isConnected() {
            AF.request(
                url,
                parameters: parameters
            )
                .validate()
                .responseJSON { response in
                    switch response.result {
                    case .success:
                        guard let data = response.data else { return }
                        do {
                            let data = try JSONDecoder().decode(ResponseTopMovies.self, from: data)
                            self.saveMoviesData(filter, data: data)
                            completion(data, nil)
                        } catch let error {
                            print(error.localizedDescription)
                            completion(nil, .decodingError)
                        }
                    case .failure(let error):
                        print(error.localizedDescription)
                        completion(nil, .serverError)
                    }
                }
        } else {
            retrieveMoviesData(filter, completion: { data in
                completion(data, nil)
            })
        }
    }
    
    func fetchMovieDetail(id: Int, completion: @escaping(MovieDetail?, ServerError?) -> Void) {
        let url = "\(ConfigReader.baseUrl())/movie/\(id)"
        
        let parameters = [
            "api_key": ConfigReader.apiKey(),
            "language": "en-US",
        ]
        
        AF.request(
            url,
            parameters: parameters
        )
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success:
                    guard let data = response.data else { return }
                    do {
                        let data = try JSONDecoder().decode(MovieDetail.self, from: data)
                        completion(data, nil)
                    } catch let error {
                        print(error.localizedDescription)
                        completion(nil, .decodingError)
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    completion(nil, .serverError)
                }
            }
    }
    
    // MARK: - TV Series
    func fetchTVSeries(_ filter: FilterModel, page: Int, completion: @escaping(TVSerieResponse?, ServerError?) -> Void) {
        let url = "\(ConfigReader.baseUrl())/tv\(filter.filter.endpoint)"
        
        let parameters = MovieQuery(
            api_key: ConfigReader.apiKey(),
            language: "en-US",
            page: page
        )
        
        if reachability.isConnected() {
            AF.request(
                url,
                parameters: parameters
            )
                .validate()
                .responseJSON { response in
                    switch response.result {
                    case .success:
                        guard let data = response.data else { return }
                        do {
                            let data = try JSONDecoder().decode(TVSerieResponse.self, from: data)
                            self.saveTVSeriesData(filter, data: data)
                            completion(data, nil)
                        } catch let error {
                            print(error.localizedDescription)
                            completion(nil, .decodingError)
                        }
                    case .failure(let error):
                        print(error.localizedDescription)
                        completion(nil, .serverError)
                    }
                }
        } else {
            retrieveTVSeriesData(filter, completion: { data in
                completion(data, nil)
            })
        }
    }
    
    func fetchTVSerieDetail(id: Int, completion: @escaping(TVSerieDetail?, ServerError?) -> Void) {
        let url = "\(ConfigReader.baseUrl())/tv/\(id)"
        
        let parameters = [
            "api_key": ConfigReader.apiKey(),
            "language": "en-US",
        ]
        
        AF.request(
            url,
            parameters: parameters
        )
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success:
                    guard let data = response.data else { return }
                    do {
                        let data = try JSONDecoder().decode(TVSerieDetail.self, from: data)
                        completion(data, nil)
                    } catch let error {
                        print(error.localizedDescription)
                        completion(nil, .decodingError)
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    completion(nil, .serverError)
                }
            }
    }
    
    // MARK: - Local Storage
    func saveMoviesData(_ filter: FilterModel, data: ResponseTopMovies) {
        switch filter.filter.type {
        case .popular:
            MovieStorage.shared.saveAllOnDisk(movies: data.results, category: .popular)
        case .topRated:
            MovieStorage.shared.saveAllOnDisk(movies: data.results, category: .topRated)
        case .upcoming:
            MovieStorage.shared.saveAllOnDisk(movies: data.results, category: .upcoming)
        }
    }
    
    func retrieveMoviesData(_ filter: FilterModel, completion: @escaping(ResponseTopMovies?) -> Void) {
        let movieStorage = MovieStorage.shared
        
        switch filter.filter.type {
        case .popular:
            let data = ResponseTopMovies(page: 1, results: movieStorage.retrieveArray(category: .popular), totalPages: 100, totalResults: 100)
            completion(data)
        case .topRated:
            let data = ResponseTopMovies(page: 1, results: movieStorage.retrieveArray(category: .topRated), totalPages: 100, totalResults: 100)
            completion(data)
        case .upcoming:
            let data = ResponseTopMovies(page: 1, results: movieStorage.retrieveArray(category: .upcoming), totalPages: 100, totalResults: 100)
            completion(data)
        }
    }
    
    func saveTVSeriesData(_ filter: FilterModel, data: TVSerieResponse) {
        switch filter.filter.type {
        case .popular:
            TVSerieStorage.shared.saveAllOnDisk(movies: data.results, category: .popular)
        case .topRated:
            TVSerieStorage.shared.saveAllOnDisk(movies: data.results, category: .topRated)
        case .upcoming:
            TVSerieStorage.shared.saveAllOnDisk(movies: data.results, category: .upcoming)
        }
    }
    
    func retrieveTVSeriesData(_ filter: FilterModel, completion: @escaping(TVSerieResponse?) -> Void) {
        let tvserieStorage = TVSerieStorage.shared
        
        switch filter.filter.type {
        case .popular:
            let data = TVSerieResponse(page: 1, results: tvserieStorage.retrieveArray(category: .popular), totalPages: 100, totalResults: 100)
            completion(data)
        case .topRated:
            let data = TVSerieResponse(page: 1, results: tvserieStorage.retrieveArray(category: .topRated), totalPages: 100, totalResults: 100)
            completion(data)
        case .upcoming:
            let data = TVSerieResponse(page: 1, results: tvserieStorage.retrieveArray(category: .upcoming), totalPages: 100, totalResults: 100)
            completion(data)
        }
    }
}
