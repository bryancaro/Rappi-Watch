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
    func fetchMovieDetail(id: Int, completion: @escaping(MovieDetail?, ServerError?) -> Void)
    func fetchPopularMovies(page: Int, completion: @escaping(ResponseTopMovies?, ServerError?) -> Void)
    func fetchTopRatedMovies(page: Int, completion: @escaping(ResponseTopMovies?, ServerError?) -> Void)
    func fetchUpComingMovies(page: Int, completion: @escaping(Upcoming?, ServerError?) -> Void)
    
    // MARK: - TV Series
    func fetchTVSerieDetail(id: Int, completion: @escaping(TVSerieDetail?, ServerError?) -> Void)
    func fetchPopularTVSeries(page: Int, completion: @escaping(TVSerieResponse?, ServerError?) -> Void)
    func fetchTopRatedTVSeries(page: Int, completion: @escaping(TVSerieResponse?, ServerError?) -> Void)
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
    
    func fetchPopularMovies(page: Int, completion: @escaping(ResponseTopMovies?, ServerError?) -> Void) {
        let url = "\(ConfigReader.baseUrl())/movie/popular"
        
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
                            MovieStorage.shared.saveAllOnDisk(movies: data.results, category: .popular)
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
            let movieStorage = MovieStorage.shared
            let data = ResponseTopMovies(page: 1, results: movieStorage.retrieveArray(category: .popular), totalPages: 100, totalResults: 100)
            completion(data, nil)
        }
    }
    
    func fetchTopRatedMovies(page: Int, completion: @escaping(ResponseTopMovies?, ServerError?) -> Void) {
        let url = "\(ConfigReader.baseUrl())/movie/top_rated"
        
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
                            MovieStorage.shared.saveAllOnDisk(movies: data.results, category: .topRated)
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
            let movieStorage = MovieStorage.shared
            let data = ResponseTopMovies(page: 1, results: movieStorage.retrieveArray(category: .topRated), totalPages: 100, totalResults: 100)
            completion(data, nil)
        }
    }
    
    func fetchUpComingMovies(page: Int, completion: @escaping(Upcoming?, ServerError?) -> Void) {
        let url = "\(ConfigReader.baseUrl())/movie/upcoming"
        
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
                    case .success(_):
                        guard let data = response.data else { return }
                        do {
                            let data = try JSONDecoder().decode(Upcoming.self, from: data)
                            MovieStorage.shared.saveAllOnDisk(movies: data.results, category: .upcoming)
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
            let movieStorage = MovieStorage.shared
            let data = Upcoming(dates: Dates(maximum: "", minimum: ""), page: 1, results: movieStorage.retrieveArray(category: .upcoming), totalPages: 100, totalResults: 100)
            completion(data, nil)
        }
    }
    
    // MARK: - TV Series
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
    
    func fetchPopularTVSeries(page: Int, completion: @escaping(TVSerieResponse?, ServerError?) -> Void) {
        let url = "\(ConfigReader.baseUrl())/tv/popular"
        
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
                            TVSerieStorage.shared.saveAllOnDisk(movies: data.results, category: .popular)
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
            let tvserieStorage = TVSerieStorage.shared
            let data = TVSerieResponse(page: 1, results: tvserieStorage.retrieveArray(category: .popular), totalPages: 100, totalResults: 100)
            completion(data, nil)
        }
    }
    
    func fetchTopRatedTVSeries(page: Int, completion: @escaping(TVSerieResponse?, ServerError?) -> Void) {
        let url = "\(ConfigReader.baseUrl())/tv/top_rated"
        
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
                            TVSerieStorage.shared.saveAllOnDisk(movies: data.results, category: .topRated)
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
            let tvserieStorage = TVSerieStorage.shared
            let data = TVSerieResponse(page: 1, results: tvserieStorage.retrieveArray(category: .topRated), totalPages: 100, totalResults: 100)
            completion(data, nil)
        }
    }
}
