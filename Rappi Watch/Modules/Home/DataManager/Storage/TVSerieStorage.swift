//
//  TVSerieStorage.swift
//  Rappi Watch
//
//  Created by Bryan Caro on 11/1/21.
//

import Foundation

class TVSerieStorage {
    static let shared = TVSerieStorage()
    
    private(set) var popularTVSerie: [TVSerie]
    private(set) var topRatedTVSerie: [TVSerie]
    private(set) var upcomingTVSerie: [TVSerie]
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
        
        self.popularTVSerie = [TVSerie]()
        self.topRatedTVSerie = [TVSerie]()
        self.upcomingTVSerie = [TVSerie]()
        
        if directoryExistsAtPath(documentsURL.appendingPathComponent("PopularTV").path) {
            moviesFilesURLs = try! fileManager.contentsOfDirectory(at: documentsURL.appendingPathComponent("PopularTV"), includingPropertiesForKeys: nil)
            
            
            popularTVSerie = moviesFilesURLs.compactMap { url -> TVSerie? in
                guard !url.absoluteString.contains(".DS_Store") else {
                    return nil
                }
                guard let data = try? Data(contentsOf: url) else {
                    return nil
                }
                return try? jsonDecoder.decode(TVSerie.self, from: data)
            }.sorted(by: { $0.popularity > $1.popularity })
        } else {
            try? fileManager.createDirectory(at: documentsURL.appendingPathComponent("PopularTV"), withIntermediateDirectories: false, attributes: nil)
        }
        
        if directoryExistsAtPath(documentsURL.appendingPathComponent("Top-RatedTV").path) {
            moviesFilesURLs = try! fileManager.contentsOfDirectory(at: documentsURL.appendingPathComponent("Top-RatedTV"), includingPropertiesForKeys: nil)
            
            topRatedTVSerie = moviesFilesURLs.compactMap { url -> TVSerie? in
                guard !url.absoluteString.contains(".DS_Store") else {
                    return nil
                }
                guard let data = try? Data(contentsOf: url) else {
                    return nil
                }
                return try? jsonDecoder.decode(TVSerie.self, from: data)
            }.sorted(by: { $0.voteAverage > $1.voteAverage })
        }
        else{
            try? fileManager.createDirectory(at: documentsURL.appendingPathComponent("Top-RatedTV"), withIntermediateDirectories: false, attributes: nil)
        }
        
        if directoryExistsAtPath(documentsURL.appendingPathComponent("Up-ComingTV").path) {
            moviesFilesURLs = try! fileManager.contentsOfDirectory(at: documentsURL.appendingPathComponent("Up-ComingTV"), includingPropertiesForKeys: nil)
            upcomingTVSerie = moviesFilesURLs.compactMap { url -> TVSerie? in
                guard !url.absoluteString.contains(".DS_Store") else {
                    return nil
                }
                guard let data = try? Data(contentsOf: url) else {
                    return nil
                }
                return try? jsonDecoder.decode(TVSerie.self, from: data)
            }.sorted(by: { $0.firstAirDate > $1.firstAirDate })
        }
        else{
            try? fileManager.createDirectory(at: documentsURL.appendingPathComponent("Up-ComingTV"), withIntermediateDirectories: false, attributes: nil)
        }
    }
    
    func saveAllOnDisk(movies : [TVSerie], category: SideButtonCategoryState){
        for movie in movies {
            saveMovieOnDisk(movie, category: category)
        }
    }
    
    func saveMovieOnDisk(_ movie: TVSerie, category: SideButtonCategoryState) {
        let encoder = JSONEncoder()
        let title = movie.id
        let fileURL = documentsURL.appendingPathComponent("\(category.description)TV").appendingPathComponent("\(title).json")
        
        if !fileManager.fileExists(atPath: fileURL.absoluteString) {
            do {
                let data = try encoder.encode(movie)
                try data.write(to: fileURL)
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }
    
    func resetStorage() {
        var moviesFilesURLs = try! fileManager.contentsOfDirectory(at: documentsURL.appendingPathComponent("PopularTV"), includingPropertiesForKeys: nil)
        for path in moviesFilesURLs {
            try? fileManager.removeItem(at: path)
        }
        
        moviesFilesURLs = try! fileManager.contentsOfDirectory(at: documentsURL.appendingPathComponent("Top-RatedTV"), includingPropertiesForKeys: nil)
        for path in moviesFilesURLs {
            try? fileManager.removeItem(at: path)
        }
        
        moviesFilesURLs = try! fileManager.contentsOfDirectory(at: documentsURL.appendingPathComponent("Up-ComingTV"), includingPropertiesForKeys: nil)
        for path in moviesFilesURLs {
            try? fileManager.removeItem(at: path)
        }
    }
    
    func retrieveArray(category: SideButtonCategoryState) -> [TVSerie] {
        if category == .popular {
            return self.popularTVSerie
        } else if category == .topRated {
            return self.topRatedTVSerie
        } else {
            return self.upcomingTVSerie
        }
    }
}


