//
//  DataStorage.swift
//  Rappi Watch
//
//  Created by Bryan Caro on 11/13/21.
//

import Foundation

class DataStorage {
    static let shared = DataStorage()
    
    private(set) var popularMovies: [Movie]
    private(set) var topRatedMovies: [Movie]
    private(set) var upcomingMovies: [Movie]
    
    private(set) var popularTVSerie: [TVSerie]
    private(set) var topRatedTVSerie: [TVSerie]
    private(set) var upcomingTVSerie: [TVSerie]
    
    private(set) var popularPeople: [People]
    
    private let fileManager: FileManager
    private let documentsURL: URL
    
    private let keyMPopular = "\(ActiveCategorie.movies.description)-\(ActiveFilter.popular.description)"
    private let keyMTopRated = "\(ActiveCategorie.movies.description)-\(ActiveFilter.topRated.description)"
    private let keyMUpcoming = "\(ActiveCategorie.movies.description)-\(ActiveFilter.upcoming.description)"
    
    private let keyTVPopular = "\(ActiveCategorie.tvshow.description)-\(ActiveFilter.popular.description)"
    private let keyTVTopRated = "\(ActiveCategorie.tvshow.description)-\(ActiveFilter.topRated.description)"
    private let keyTVUpcoming = "\(ActiveCategorie.tvshow.description)-\(ActiveFilter.upcoming.description)"
    
    private let keyPePopular = "\(ActiveCategorie.people.description)-\(ActiveFilter.popular.description)"
    
    func directoryExistsAtPath(_ path: String) -> Bool {
        var isDirectory = ObjCBool(true)
        let exists = fileManager.fileExists(atPath: path, isDirectory: &isDirectory)
        return exists && isDirectory.boolValue
    }
    
    init() {
        let fileManager = FileManager.default
        self.documentsURL = try! fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        self.fileManager = fileManager
        var moviesFilesURLs: [URL]
        let jsonDecoder = JSONDecoder()
        
        self.popularMovies = [Movie]()
        self.topRatedMovies = [Movie]()
        self.upcomingMovies = [Movie]()
        
        self.popularTVSerie = [TVSerie]()
        self.topRatedTVSerie = [TVSerie]()
        self.upcomingTVSerie = [TVSerie]()
        
        self.popularPeople = [People]()
        
        // MARK: - Movies
        if directoryExistsAtPath(documentsURL.appendingPathComponent(keyMPopular).path) {
            moviesFilesURLs = try! fileManager.contentsOfDirectory(at: documentsURL.appendingPathComponent(keyMPopular), includingPropertiesForKeys: nil)
            
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
            try? fileManager.createDirectory(at: documentsURL.appendingPathComponent(keyMPopular), withIntermediateDirectories: false, attributes: nil)
        }
        
        if directoryExistsAtPath(documentsURL.appendingPathComponent(keyMTopRated).path) {
            moviesFilesURLs = try! fileManager.contentsOfDirectory(at: documentsURL.appendingPathComponent(keyMTopRated), includingPropertiesForKeys: nil)
            
            topRatedMovies = moviesFilesURLs.compactMap { url -> Movie? in
                guard !url.absoluteString.contains(".DS_Store") else {
                    return nil
                }
                guard let data = try? Data(contentsOf: url) else {
                    return nil
                }
                return try? jsonDecoder.decode(Movie.self, from: data)
            }.sorted(by: { $0.voteAverage > $1.voteAverage })
        } else {
            try? fileManager.createDirectory(at: documentsURL.appendingPathComponent(keyMTopRated), withIntermediateDirectories: false, attributes: nil)
        }
        
        if directoryExistsAtPath(documentsURL.appendingPathComponent(keyMUpcoming).path) {
            moviesFilesURLs = try! fileManager.contentsOfDirectory(at: documentsURL.appendingPathComponent(keyMUpcoming), includingPropertiesForKeys: nil)
            upcomingMovies = moviesFilesURLs.compactMap { url -> Movie? in
                guard !url.absoluteString.contains(".DS_Store") else {
                    return nil
                }
                guard let data = try? Data(contentsOf: url) else {
                    return nil
                }
                return try? jsonDecoder.decode(Movie.self, from: data)
            }.sorted(by: { $0.releaseDate > $1.releaseDate })
        } else {
            try? fileManager.createDirectory(at: documentsURL.appendingPathComponent(keyMUpcoming), withIntermediateDirectories: false, attributes: nil)
        }
        
        // MARK: - TV Series
        if directoryExistsAtPath(documentsURL.appendingPathComponent(keyTVPopular).path) {
            moviesFilesURLs = try! fileManager.contentsOfDirectory(at: documentsURL.appendingPathComponent(keyTVPopular), includingPropertiesForKeys: nil)
            
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
            try? fileManager.createDirectory(at: documentsURL.appendingPathComponent(keyTVPopular), withIntermediateDirectories: false, attributes: nil)
        }
        
        if directoryExistsAtPath(documentsURL.appendingPathComponent(keyTVTopRated).path) {
            moviesFilesURLs = try! fileManager.contentsOfDirectory(at: documentsURL.appendingPathComponent(keyTVTopRated), includingPropertiesForKeys: nil)
            
            topRatedTVSerie = moviesFilesURLs.compactMap { url -> TVSerie? in
                guard !url.absoluteString.contains(".DS_Store") else {
                    return nil
                }
                guard let data = try? Data(contentsOf: url) else {
                    return nil
                }
                return try? jsonDecoder.decode(TVSerie.self, from: data)
            }.sorted(by: { $0.voteAverage > $1.voteAverage })
        } else {
            try? fileManager.createDirectory(at: documentsURL.appendingPathComponent(keyTVTopRated), withIntermediateDirectories: false, attributes: nil)
        }
        
        if directoryExistsAtPath(documentsURL.appendingPathComponent(keyTVUpcoming).path) {
            moviesFilesURLs = try! fileManager.contentsOfDirectory(at: documentsURL.appendingPathComponent(keyTVUpcoming), includingPropertiesForKeys: nil)
            
            upcomingTVSerie = moviesFilesURLs.compactMap { url -> TVSerie? in
                guard !url.absoluteString.contains(".DS_Store") else {
                    return nil
                }
                guard let data = try? Data(contentsOf: url) else {
                    return nil
                }
                return try? jsonDecoder.decode(TVSerie.self, from: data)
            }.sorted(by: { $0.firstAirDate > $1.firstAirDate })
        } else {
            try? fileManager.createDirectory(at: documentsURL.appendingPathComponent(keyTVUpcoming), withIntermediateDirectories: false, attributes: nil)
        }
        
        // MARK: - People
        if directoryExistsAtPath(documentsURL.appendingPathComponent(keyPePopular).path) {
            moviesFilesURLs = try! fileManager.contentsOfDirectory(at: documentsURL.appendingPathComponent(keyPePopular), includingPropertiesForKeys: nil)
            
            popularPeople = moviesFilesURLs.compactMap { url -> People? in
                guard !url.absoluteString.contains(".DS_Store") else {
                    return nil
                }
                guard let data = try? Data(contentsOf: url) else {
                    return nil
                }
                return try? jsonDecoder.decode(People.self, from: data)
            }.sorted(by: { $0.popularity > $1.popularity })
        } else {
            try? fileManager.createDirectory(at: documentsURL.appendingPathComponent(keyPePopular), withIntermediateDirectories: false, attributes: nil)
        }
    }
    
    func saveAllOnDisk(movies: [Movie]? = nil, tvSeries: [TVSerie]? = nil, peoples: [People]? = nil, filter: ActiveFilter, category: ActiveCategorie) {
        switch category {
        case .movies:
            guard let movies = movies else { return }
            for movie in movies {
                saveMovieOnDisk(movie, filter: filter, category: category)
            }
        case .tvshow:
            guard let tvSeries = tvSeries else { return }
            for serie in tvSeries {
                saveTVSerieOnDisk(serie, filter: filter, category: category)
            }
        case .people:
            guard let peoples = peoples else { return }
            for people in peoples {
                savePeopleOnDisk(people, filter: filter, category: category)
            }
        }
    }
    
    func saveMovieOnDisk(_ movie: Movie, filter: ActiveFilter, category: ActiveCategorie) {
        let encoder = JSONEncoder()
        let title = movie.title
        let fileURL = documentsURL.appendingPathComponent("\(category.description)-\(filter.description)").appendingPathComponent("\(title).json")
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
    
    func saveTVSerieOnDisk(_ tvserie: TVSerie, filter: ActiveFilter, category: ActiveCategorie) {
        let encoder = JSONEncoder()
        let title = tvserie.name
        let fileURL = documentsURL.appendingPathComponent("\(category.description)-\(filter.description)").appendingPathComponent("\(title).json")
        
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
    
    func savePeopleOnDisk(_ people: People, filter: ActiveFilter, category: ActiveCategorie) {
        let encoder = JSONEncoder()
        let title = people.name
        let fileURL = documentsURL.appendingPathComponent("\(category.description)-\(filter.description)").appendingPathComponent("\(title).json")
        
        if !fileManager.fileExists(atPath: fileURL.absoluteString) {
            do {
                let data = try encoder.encode(people)
                try data.write(to: fileURL)
                print("Saved \(title)")
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }
    
    //    func resetStorage() {
    //        var moviesFilesURLs = try! fileManager.contentsOfDirectory(at: documentsURL.appendingPathComponent(keyPopular), includingPropertiesForKeys: nil)
    //        for path in moviesFilesURLs {
    //            try? fileManager.removeItem(at: path)
    //        }
    //
    //        moviesFilesURLs = try! fileManager.contentsOfDirectory(at: documentsURL.appendingPathComponent(keyTopRated), includingPropertiesForKeys: nil)
    //        for path in moviesFilesURLs {
    //            try? fileManager.removeItem(at: path)
    //        }
    //
    //        moviesFilesURLs = try! fileManager.contentsOfDirectory(at: documentsURL.appendingPathComponent(keyUpcoming), includingPropertiesForKeys: nil)
    //        for path in moviesFilesURLs {
    //            try? fileManager.removeItem(at: path)
    //        }
    //    }
    
    func retrieveMoviesArray(filter: ActiveFilter) -> [Movie] {
        switch filter {
        case .popular:
            return self.popularMovies
        case .topRated:
            return self.topRatedMovies
        case .upcoming:
            return self.upcomingMovies
        }
    }
    
    func retrieveTVSerieArray(filter: ActiveFilter) -> [TVSerie] {
        switch filter {
        case .popular:
            return self.popularTVSerie
        case .topRated:
            return self.topRatedTVSerie
        case .upcoming:
            return [TVSerie]()
        }
    }
    
    func retrievePeoplesArray(filter: ActiveFilter) -> [People] {
        switch filter {
        case .popular:
            return self.popularPeople
        case .topRated:
            return [People]()
        case .upcoming:
            return [People]()
        }
    }
}
