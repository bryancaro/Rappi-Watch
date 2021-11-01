//
//  TVSerieRepository.swift
//  Rappi Watch
//
//  Created by Bryan Caro on 10/30/21.
//

import Foundation

protocol TVSerieRepositoryProtocol {
    func fetchTVSerieDetail(id: Int, completion: @escaping(TVSerieDetail?, ServerError?) -> Void)
}

class TVSerieRepository {
    private let server: ServerManager
    //    private let local  = UserLocalService()
    
    init(server: ServerManager = ServerManager()) {
        self.server = server
    }
}

extension TVSerieRepository: TVSerieRepositoryProtocol {
    func fetchTVSerieDetail(id: Int, completion: @escaping(TVSerieDetail?, ServerError?) -> Void) {
        server.fetchTVSerieDetail(id: id, completion: completion)
    }
}
