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
        
        self.popularTVSerie = [TVSerie]()
        self.topRatedTVSerie = [TVSerie]()
        self.upcomingTVSerie = [TVSerie]()
        
        if directoryExistsAtPath(documentsURL.appendingPathComponent("\(keyPopular)TV").path) {
            moviesFilesURLs = try! fileManager.contentsOfDirectory(at: documentsURL.appendingPathComponent("\(keyPopular)TV"), includingPropertiesForKeys: nil)
            
            
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
            try? fileManager.createDirectory(at: documentsURL.appendingPathComponent("\(keyPopular)TV"), withIntermediateDirectories: false, attributes: nil)
        }
        
        if directoryExistsAtPath(documentsURL.appendingPathComponent("\(keyTopRated)TV").path) {
            moviesFilesURLs = try! fileManager.contentsOfDirectory(at: documentsURL.appendingPathComponent("\(keyTopRated)TV"), includingPropertiesForKeys: nil)
            
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
            try? fileManager.createDirectory(at: documentsURL.appendingPathComponent("\(keyTopRated)TV"), withIntermediateDirectories: false, attributes: nil)
        }
        
        if directoryExistsAtPath(documentsURL.appendingPathComponent("\(keyUpcoming)TV").path) {
            moviesFilesURLs = try! fileManager.contentsOfDirectory(at: documentsURL.appendingPathComponent("\(keyUpcoming)TV"), includingPropertiesForKeys: nil)
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
            try? fileManager.createDirectory(at: documentsURL.appendingPathComponent("\(keyUpcoming)TV"), withIntermediateDirectories: false, attributes: nil)
        }
    }
    
    func saveAllOnDisk(tvseries : [TVSerie], filter: ActiveFilter){
        for tvserie in tvseries {
            saveMovieOnDisk(tvserie, filter: filter)
        }
    }
    
    func saveMovieOnDisk(_ tvserie: TVSerie, filter: ActiveFilter) {
        let encoder = JSONEncoder()
        let title = tvserie.name
        let fileURL = documentsURL.appendingPathComponent("\(filter)TV").appendingPathComponent("\(title).json")
        
        if !fileManager.fileExists(atPath: fileURL.absoluteString) {
            do {
                let data = try encoder.encode(tvserie)
                try data.write(to: fileURL)
                print("Saved \(title)")
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }
    
    func resetStorage() {
        var moviesFilesURLs = try! fileManager.contentsOfDirectory(at: documentsURL.appendingPathComponent("\(keyPopular)TV"), includingPropertiesForKeys: nil)
        for path in moviesFilesURLs {
            try? fileManager.removeItem(at: path)
        }
        
        moviesFilesURLs = try! fileManager.contentsOfDirectory(at: documentsURL.appendingPathComponent("\(keyTopRated)TV"), includingPropertiesForKeys: nil)
        for path in moviesFilesURLs {
            try? fileManager.removeItem(at: path)
        }
        
        moviesFilesURLs = try! fileManager.contentsOfDirectory(at: documentsURL.appendingPathComponent("\(keyUpcoming)TV"), includingPropertiesForKeys: nil)
        for path in moviesFilesURLs {
            try? fileManager.removeItem(at: path)
        }
    }
    
    func retrieveArray(filter: ActiveFilter) -> [TVSerie] {
        switch filter {
        case .popular:
            return self.popularTVSerie
        case .topRated:
            return self.topRatedTVSerie
        case .upcoming:
            return self.upcomingTVSerie
        }
    }
}


