//
//  MovieStorage.swift
//  Rappi Watch
//
//  Created by Bryan Caro on 11/1/21.
//

import Foundation

class MovieStorage {
    static let shared = MovieStorage()
    
    private(set) var popularMovies: [Movie]
    private(set) var topRatedMovies: [Movie]
    private(set) var upcomingMovies: [Movie]
    
    private let fileManager: FileManager
    private let documentsURL: URL
    
    private let keyPopular = "filter_button_first_title".localized
    private let keyTopRated = "filter_button_second_title".localized
    private let keyUpcoming = "filter_button_third_title".localized
    
    func directoryExistsAtPath(_ path: String) -> Bool {
        var isDirectory = ObjCBool(true)
        let exists = fileManager.fileExists(atPath: path, isDirectory: &isDirectory)
        return exists && isDirectory.boolValue
    }
    
    init() {
        let fileManager = FileManager.default
        self.documentsURL = try! fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        self.fileManager = fileManager
        var moviesFilesURLs : [URL]
        let jsonDecoder = JSONDecoder()
        
        self.popularMovies = [Movie]()
        self.topRatedMovies = [Movie]()
        self.upcomingMovies = [Movie]()
        
        if directoryExistsAtPath(documentsURL.appendingPathComponent(keyPopular).path) {
            moviesFilesURLs = try! fileManager.contentsOfDirectory(at: documentsURL.appendingPathComponent(keyPopular), includingPropertiesForKeys: nil)
            
            
            popularMovies = moviesFilesURLs.compactMap { url -> Movie? in
                guard !url.absoluteString.contains(".DS_Store") else {
                    return nil
                }
                guard let data = try? Data(contentsOf: url) else {
                    return nil
                }
                return try? jsonDecoder.decode(Movie.self, from: data)
            }.sorted(by: { $0.popularity > $1.popularity })
        } else {
            try? fileManager.createDirectory(at: documentsURL.appendingPathComponent(keyPopular), withIntermediateDirectories: false, attributes: nil)
        }
        
        if directoryExistsAtPath(documentsURL.appendingPathComponent(keyTopRated).path) {
            moviesFilesURLs = try! fileManager.contentsOfDirectory(at: documentsURL.appendingPathComponent(keyTopRated), includingPropertiesForKeys: nil)
            
            topRatedMovies = moviesFilesURLs.compactMap { url -> Movie? in
                guard !url.absoluteString.contains(".DS_Store") else {
                    return nil
                }
                guard let data = try? Data(contentsOf: url) else {
                    return nil
                }
                return try? jsonDecoder.decode(Movie.self, from: data)
            }.sorted(by: { $0.voteAverage > $1.voteAverage })
        }
        else{
            try? fileManager.createDirectory(at: documentsURL.appendingPathComponent(keyTopRated), withIntermediateDirectories: false, attributes: nil)
        }
        
        if directoryExistsAtPath(documentsURL.appendingPathComponent(keyUpcoming).path) {
            moviesFilesURLs = try! fileManager.contentsOfDirectory(at: documentsURL.appendingPathComponent(keyUpcoming), includingPropertiesForKeys: nil)
            upcomingMovies = moviesFilesURLs.compactMap { url -> Movie? in
                guard !url.absoluteString.contains(".DS_Store") else {
                    return nil
                }
                guard let data = try? Data(contentsOf: url) else {
                    return nil
                }
                return try? jsonDecoder.decode(Movie.self, from: data)
            }.sorted(by: { $0.releaseDate > $1.releaseDate })
        }
        else{
            try? fileManager.createDirectory(at: documentsURL.appendingPathComponent(keyUpcoming), withIntermediateDirectories: false, attributes: nil)
        }
    }
    
    func saveAllOnDisk(movies : [Movie], filter: ActiveFilter){
        for movie in movies {
            saveMovieOnDisk(movie, filter: filter)
        }
    }
    
    func saveMovieOnDisk(_ movie: Movie, filter: ActiveFilter) {
        let encoder = JSONEncoder()
        let title = movie.title
        let fileURL = documentsURL.appendingPathComponent(filter.description).appendingPathComponent("\(title).json")
        
        if !fileManager.fileExists(atPath: fileURL.absoluteString) {
            do {
                let data = try encoder.encode(movie)
                try data.write(to: fileURL)
                print("Saved \(title)")
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }
    
    func resetStorage() {
        var moviesFilesURLs = try! fileManager.contentsOfDirectory(at: documentsURL.appendingPathComponent(keyPopular), includingPropertiesForKeys: nil)
        for path in moviesFilesURLs {
            try? fileManager.removeItem(at: path)
        }
        
        moviesFilesURLs = try! fileManager.contentsOfDirectory(at: documentsURL.appendingPathComponent(keyTopRated), includingPropertiesForKeys: nil)
        for path in moviesFilesURLs {
            try? fileManager.removeItem(at: path)
        }
        
        moviesFilesURLs = try! fileManager.contentsOfDirectory(at: documentsURL.appendingPathComponent(keyUpcoming), includingPropertiesForKeys: nil)
        for path in moviesFilesURLs {
            try? fileManager.removeItem(at: path)
        }
    }
    
    func retrieveArray(filter: ActiveFilter) -> [Movie] {
        switch filter {
        case .popular:
            return self.popularMovies
        case .topRated:
            return self.topRatedMovies
        case .upcoming:
            return self.upcomingMovies
        }
    }
}
