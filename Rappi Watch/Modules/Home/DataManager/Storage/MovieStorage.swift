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
        
        if directoryExistsAtPath(documentsURL.appendingPathComponent("Popular").path) {
            moviesFilesURLs = try! fileManager.contentsOfDirectory(at: documentsURL.appendingPathComponent("Popular"), includingPropertiesForKeys: nil)
            
            
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
            try? fileManager.createDirectory(at: documentsURL.appendingPathComponent("Popular"), withIntermediateDirectories: false, attributes: nil)
        }
        
        if directoryExistsAtPath(documentsURL.appendingPathComponent("Top-Rated").path) {
            moviesFilesURLs = try! fileManager.contentsOfDirectory(at: documentsURL.appendingPathComponent("Popular"), includingPropertiesForKeys: nil)
            
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
            try? fileManager.createDirectory(at: documentsURL.appendingPathComponent("Top-Rated"), withIntermediateDirectories: false, attributes: nil)
        }
        
        if directoryExistsAtPath(documentsURL.appendingPathComponent("Up-Coming").path) {
            moviesFilesURLs = try! fileManager.contentsOfDirectory(at: documentsURL.appendingPathComponent("Up-Coming"), includingPropertiesForKeys: nil)
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
            try? fileManager.createDirectory(at: documentsURL.appendingPathComponent("Up-Coming"), withIntermediateDirectories: false, attributes: nil)
        }
    }
    
    func saveAllOnDisk(movies : [Movie], category: SideButtonCategoryState){
        for movie in movies {
            saveMovieOnDisk(movie, category: category)
        }
    }
    
    func saveMovieOnDisk(_ movie: Movie, category: SideButtonCategoryState) {
        print("DEBUG: Saving....")
        let encoder = JSONEncoder()
        let title = movie.id
        let fileURL = documentsURL.appendingPathComponent(category.description).appendingPathComponent("\(title).json")
        
        if !fileManager.fileExists(atPath: fileURL.absoluteString) {
            do {
                let data = try encoder.encode(movie)
                try data.write(to: fileURL)
            } catch let error {
                print(error.localizedDescription)
            }
        } else {
            print("DEBUG: Documento ya existe")
        }
    }
    
    func resetStorage() {
        var moviesFilesURLs = try! fileManager.contentsOfDirectory(at: documentsURL.appendingPathComponent("Popular"), includingPropertiesForKeys: nil)
        for path in moviesFilesURLs {
            try? fileManager.removeItem(at: path)
        }
        
        moviesFilesURLs = try! fileManager.contentsOfDirectory(at: documentsURL.appendingPathComponent("Top-Rated"), includingPropertiesForKeys: nil)
        for path in moviesFilesURLs {
            try? fileManager.removeItem(at: path)
        }
        
        moviesFilesURLs = try! fileManager.contentsOfDirectory(at: documentsURL.appendingPathComponent("Up-Coming"), includingPropertiesForKeys: nil)
        for path in moviesFilesURLs {
            try? fileManager.removeItem(at: path)
        }
    }
    
    func retrieveArray(category: SideButtonCategoryState) -> [Movie] {
        if category == .popular {
            return self.popularMovies
        } else if category == .topRated {
            return self.topRatedMovies
        } else {
            return self.upcomingMovies
        }
    }
}
