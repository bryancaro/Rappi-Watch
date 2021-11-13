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
    func fetchMovies(_ filter: FilterModel, _ category: CategoriesModel, page: Int, completion: @escaping(ResponseTopMovies?, ServerError?) -> Void)
    func fetchMovieDetail(id: Int, completion: @escaping(MovieDetail?, ServerError?) -> Void)
    
    // MARK: - TV Series
    func fetchTVSeries(_ filter: FilterModel, _ category: CategoriesModel, page: Int, completion: @escaping(TVSerieResponse?, ServerError?) -> Void)
    func fetchTVSerieDetail(id: Int, completion: @escaping(TVSerieDetail?, ServerError?) -> Void)
    
    // MARK: - People
    func fetchPeople(_ filter: FilterModel, _ category: CategoriesModel, page: Int, completion: @escaping(PeopleResponse?, ServerError?) -> Void)
}

final class ServerManager: ServerManagerProtocol {
    // MARK: - Movies
    func fetchMovies(_ filter: FilterModel, _ category: CategoriesModel, page: Int, completion: @escaping(ResponseTopMovies?, ServerError?) -> Void) {
        let url = "\(ConfigReader.baseUrl())/movie\(filter.filter.endpoint)"
        
        let parameters = MovieQuery(
            api_key: ConfigReader.apiKey(),
            language: "en-US",
            page: page
        )
        
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
                        DataStorage.shared.saveAllOnDisk(movies: data.results, filter: filter.filter.active, category: category.category.active)
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
    func fetchTVSeries(_ filter: FilterModel, _ category: CategoriesModel, page: Int, completion: @escaping(TVSerieResponse?, ServerError?) -> Void) {
        let url = "\(ConfigReader.baseUrl())/tv\(filter.filter.endpoint)"
        
        let parameters = MovieQuery(
            api_key: ConfigReader.apiKey(),
            language: "en-US",
            page: page
        )
        
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
                        DataStorage.shared.saveAllOnDisk(tvSeries: data.results, filter: filter.filter.active, category: category.category.active)
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
    
    // MARK: - People
    func fetchPeople(_ filter: FilterModel, _ category: CategoriesModel, page: Int, completion: @escaping(PeopleResponse?, ServerError?) -> Void) {
        let url = "\(ConfigReader.baseUrl())/person\(filter.filter.endpoint)"
        
        let parameters = MovieQuery(
            api_key: ConfigReader.apiKey(),
            language: "en-US",
            page: page
        )
        
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
                        let data = try JSONDecoder().decode(PeopleResponse.self, from: data)
                        DataStorage.shared.saveAllOnDisk(peoples: data.results, filter: filter.filter.active, category: category.category.active)
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
}
