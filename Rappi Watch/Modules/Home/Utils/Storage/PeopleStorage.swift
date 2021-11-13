//
//  PeopleStorage.swift
//  Rappi Watch
//
//  Created by Bryan Caro on 11/13/21.
//

import Foundation

class PeopleStorage {
    static let shared = PeopleStorage()
    
    private(set) var popularPeople: [People]
    
    private let fileManager: FileManager
    private let documentsURL: URL
    
    private let keyPopular = "filter_button_first_title".localized
    
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
        
        self.popularPeople = [People]()
        
        if directoryExistsAtPath(documentsURL.appendingPathComponent("\(keyPopular)People").path) {
            moviesFilesURLs = try! fileManager.contentsOfDirectory(at: documentsURL.appendingPathComponent("\(keyPopular)People"), includingPropertiesForKeys: nil)
            
            
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
            try? fileManager.createDirectory(at: documentsURL.appendingPathComponent("\(keyPopular)People"), withIntermediateDirectories: false, attributes: nil)
        }
    }
    
    func saveAllOnDisk(peoples : [People], filter: ActiveFilter){
        for people in peoples {
            saveMovieOnDisk(people, filter: filter)
        }
    }
    
    func saveMovieOnDisk(_ people: People, filter: ActiveFilter) {
        let encoder = JSONEncoder()
        let title = people.name
        let fileURL = documentsURL.appendingPathComponent("\(filter.description)People").appendingPathComponent("\(title).json")
        
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
    
    func resetStorage() {
        var moviesFilesURLs = try! fileManager.contentsOfDirectory(at: documentsURL.appendingPathComponent(keyPopular), includingPropertiesForKeys: nil)
        for path in moviesFilesURLs {
            try? fileManager.removeItem(at: path)
        }
    }
    
    func retrieveArray(filter: ActiveFilter) -> [People] {
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
