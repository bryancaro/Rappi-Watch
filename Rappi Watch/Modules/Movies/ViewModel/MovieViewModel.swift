//
//  MovieDetailsViewModel.swift
//  Rappi Watch
//
//  Created by Bryan Caro on 10/30/21.
//

import Foundation
import Combine

class MovieViewModel: ObservableObject {
    struct AppError: Identifiable {
        let id = UUID().uuidString
        let errorString: String
    }
    @Published var appError  : AppError? = nil
    @Published var isLoading : Bool = true
    
    @Published var detail: MovieDetailModel = emptyMovieDetailModel
    
    private let repository: MovieRepositoryProtocol
    init(repository: MovieRepositoryProtocol = MovieRepository()) {
        self.repository = repository
    }
    
    func fetchDetail(id: Int) {
        repository.fetchMovieDetail(id: id, completion: { detail, error in
            if let error = error {
                haptic(type: .error)
                dismissLoadingView {
                    self.isLoading = false
                    self.appError = AppError(errorString: error.localizedDescription)
                }
                return
            }
            
            guard let detail = detail else { return }
            self.detail = MovieDetailModel(detail: detail)
        })
    }
}

struct MovieDetailModel: Identifiable, Hashable {
    var id: String
    var movie: MovieDetail
    
    init(detail: MovieDetail) {
        self.id = UUID().uuidString
        self.movie = detail
    }
}

let emptyMovieDetailModel = MovieDetailModel(detail: emptyMovieDetail)
