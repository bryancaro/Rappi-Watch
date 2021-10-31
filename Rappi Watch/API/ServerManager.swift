//
//  ServerManager.swift
//  Rappi Watch
//
//  Created by Bryan Caro on 10/29/21.
//

import Foundation
import Alamofire
import CodableFirebase

protocol ServerManagerProtocol {
    // MARK: - Movies
    func fetchMovieDetail(id: Int, completion: @escaping(MovieDetail?, Error?) -> Void)
    func fetchPopularMovies(page: Int, completion: @escaping(ResponseTopMovies?, Error?) -> Void)
    func fetchTopRatedMovies(page: Int, completion: @escaping(ResponseTopMovies?, Error?) -> Void)
    func fetchUpComingMovies(page: Int, completion: @escaping(Upcoming?, Error?) -> Void)
    
    // MARK: - TV Series
    func fetchTVSerieDetail(id: Int, completion: @escaping(TVSerieDetail?, Error?) -> Void)
    func fetchPopularTVSeries(page: Int, completion: @escaping(TVSerieResponse?, Error?) -> Void)
    func fetchTopRatedTVSeries(page: Int, completion: @escaping(TVSerieResponse?, Error?) -> Void)
}

struct MovieQuery: Encodable, Decodable, Hashable {
    var api_key: String
    var language: String
    var page: Int
}

final class ServerManager: ServerManagerProtocol {
    // MARK: - Movies
    func fetchMovieDetail(id: Int, completion: @escaping(MovieDetail?, Error?) -> Void) {
        let url = "\(ConfigReader.baseUrl())/movie/\(id)"
        
        let parameters = [
            "api_key": ConfigReader.apiKey(),
            "language": "en-US",
        ]
        
        AF.request(
            url,
            parameters: parameters
        )
            .responseJSON { response in
                switch response.result {
                case .success:
                    guard let data = response.data else { return }
                    do {
                        let data = try JSONDecoder().decode(MovieDetail.self, from: data)
                        completion(data, nil)
                    } catch let error {
                        print(error.localizedDescription)
                        completion(nil, error)
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    completion(nil, error)
                }
            }
    }
    
    func fetchPopularMovies(page: Int, completion: @escaping(ResponseTopMovies?, Error?) -> Void) {
        let url = "\(ConfigReader.baseUrl())/movie/popular"
        
        let parameters = MovieQuery(
            api_key: ConfigReader.apiKey(),
            language: "en-US",
            page: page
        )
        
        AF.request(
            url,
            parameters: parameters
        )
            .responseJSON { response in
                switch response.result {
                case .success:
                    guard let data = response.data else { return }
                    do {
                        let data = try JSONDecoder().decode(ResponseTopMovies.self, from: data)
                        completion(data, nil)
                    } catch let error {
                        print(error.localizedDescription)
                        completion(nil, error)
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    completion(nil, error)
                }
            }
    }
    
    func fetchTopRatedMovies(page: Int, completion: @escaping(ResponseTopMovies?, Error?) -> Void) {
        let url = "\(ConfigReader.baseUrl())/movie/top_rated"
        
        let parameters = MovieQuery(
            api_key: ConfigReader.apiKey(),
            language: "en-US",
            page: page
        )
        
        AF.request(
            url,
            parameters: parameters
        )
            .responseJSON { response in
                switch response.result {
                case .success:
                    guard let data = response.data else { return }
                    do {
                        let data = try JSONDecoder().decode(ResponseTopMovies.self, from: data)
                        completion(data, nil)
                    } catch let error {
                        print(error.localizedDescription)
                        completion(nil, error)
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    completion(nil, error)
                }
            }
    }
    
    func fetchUpComingMovies(page: Int, completion: @escaping(Upcoming?, Error?) -> Void) {
        let url = "\(ConfigReader.baseUrl())/movie/upcoming"
        
        let parameters = MovieQuery(
            api_key: ConfigReader.apiKey(),
            language: "en-US",
            page: page
        )
        
        AF.request(
            url,
            parameters: parameters
        )
            .responseJSON { response in
                switch response.result {
                case .success(_):
                    guard let data = response.data else { return }
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                        let data = try FirestoreDecoder().decode(Upcoming.self, from: json)
                        completion(data, nil)
                    } catch let error {
                        print(error.localizedDescription)
                        completion(nil, error)
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    completion(nil, error)
                }
            }
    }
    
    // MARK: - TV Series
    func fetchTVSerieDetail(id: Int, completion: @escaping(TVSerieDetail?, Error?) -> Void) {
        let url = "\(ConfigReader.baseUrl())/tv/\(id)"
        
        let parameters = [
            "api_key": ConfigReader.apiKey(),
            "language": "en-US",
        ]
        
        AF.request(
            url,
            parameters: parameters
        )
            .responseJSON { response in
                switch response.result {
                case .success:
                    guard let data = response.data else { return }
                    do {
                        let data = try JSONDecoder().decode(TVSerieDetail.self, from: data)
                        completion(data, nil)
                    } catch let error {
                        print(error.localizedDescription)
                        completion(nil, error)
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    completion(nil, error)
                }
            }
    }
    
    func fetchPopularTVSeries(page: Int, completion: @escaping(TVSerieResponse?, Error?) -> Void) {
        let url = "\(ConfigReader.baseUrl())/tv/popular"
        
        let parameters = MovieQuery(
            api_key: ConfigReader.apiKey(),
            language: "en-US",
            page: page
        )
        
        AF.request(
            url,
            parameters: parameters
        )
            .responseJSON { response in
                switch response.result {
                case .success:
                    guard let data = response.data else { return }
                    do {
                        let data = try JSONDecoder().decode(TVSerieResponse.self, from: data)
                        completion(data, nil)
                    } catch let error {
                        print(error.localizedDescription)
                        completion(nil, error)
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    completion(nil, error)
                }
            }
    }
    
    func fetchTopRatedTVSeries(page: Int, completion: @escaping(TVSerieResponse?, Error?) -> Void) {
        let url = "\(ConfigReader.baseUrl())/tv/top_rated"
        
        let parameters = MovieQuery(
            api_key: ConfigReader.apiKey(),
            language: "en-US",
            page: page
        )
        
        AF.request(
            url,
            parameters: parameters
        )
            .responseJSON { response in
                switch response.result {
                case .success:
                    guard let data = response.data else { return }
                    do {
                        let data = try JSONDecoder().decode(TVSerieResponse.self, from: data)
                        completion(data, nil)
                    } catch let error {
                        print(error.localizedDescription)
                        completion(nil, error)
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    completion(nil, error)
                }
            }
    }
}
