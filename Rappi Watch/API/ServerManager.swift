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
    func fetchPopularMovies(page: Int, completion: @escaping(PopularRatedMovie?, Error?) -> Void)
    func fetchMovieDetail(id: Int, completion: @escaping(MovieDetail?, Error?) -> Void)
}

struct MovieQuery: Encodable, Decodable, Hashable {
    var api_key: String
    var language: String
    var page: Int
}

final class ServerManager: ServerManagerProtocol {
    func fetchPopularMovies(page: Int, completion: @escaping(PopularRatedMovie?, Error?) -> Void) {
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
                case .success(_):
                    guard let data = response.data else { return }
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                        let popularMovies = try FirestoreDecoder().decode(PopularRatedMovie.self, from: json)
                        completion(popularMovies, nil)
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
                case .success(_):
                    guard let data = response.data else { return }
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                        let detail = try FirestoreDecoder().decode(MovieDetail.self, from: json)
                        print(detail)
                        completion(detail, nil)
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
