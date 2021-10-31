//
//  TVSerieViewModel.swift
//  Rappi Watch
//
//  Created by Bryan Caro on 10/30/21.
//

import Foundation
import Combine

class TVSerieViewModel: ObservableObject {
    struct AppError: Identifiable {
        let id = UUID().uuidString
        let errorString: String
    }
    @Published var appError  : AppError? = nil
    @Published var isLoading : Bool = true
    
    @Published var detail: TVSerieDetailModel = emptyTVSerieModel
    
    private let repository: TVSerieRepositoryProtocol
    init(repository: TVSerieRepositoryProtocol = TVSerieRepository()) {
        self.repository = repository
    }
    
    func fetchDetail(id: Int) {
        repository.fetchTVSerieDetail(id: id, completion: { detail, error in
            if let error = error {
                haptic(type: .error)
                dismissLoadingView {
                    self.isLoading = false
                    self.appError = AppError(errorString: error.localizedDescription)
                }
                return
            }

            guard let detail = detail else { return }
            self.detail = TVSerieDetailModel(detail: detail)
        })
    }
}

struct TVSerieDetailModel: Identifiable, Hashable {
    var id: String
    var serie: TVSerieDetail

    init(detail: TVSerieDetail) {
        self.id = UUID().uuidString
        self.serie = detail
    }
}

let emptyTVSerieModel = TVSerieDetailModel(detail: emptyTVSerieDetail)
