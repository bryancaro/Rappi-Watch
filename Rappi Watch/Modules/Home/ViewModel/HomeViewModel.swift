//
//  HomeViewModel.swift
//  Rappi Watch
//
//  Created by Bryan Caro on 10/30/21.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    struct AppError: Identifiable {
        let id = UUID().uuidString
        let errorString: String
    }
    @Published var appError  : AppError? = nil
    @Published var isLoading : Bool = true
    
    @Published var movies: [MovieModel] = [MovieModel]()
    @Published var actualPage: Int = 1
    
    private let repository: HomeRepositoryProtocol
    init(repository: HomeRepositoryProtocol = HomeRepository()) {
        self.repository = repository
    }
    
    func fetchPopularMovies() {
        repository.fetchPopularMovies(page: actualPage, completion: { popularMovies, error in
            if let error = error {
                haptic(type: .error)
                dismissLoadingView {
                    self.isLoading = false
                    self.appError = AppError(errorString: error.localizedDescription)
                }
                return
            }
            
            guard let popularMovies = popularMovies else { return }
            self.movies = popularMovies.results.map({ MovieModel(movie: $0)})
        })
    }
}

struct MovieModel: Identifiable, Hashable {
    var id: String
    var show: Bool
    var movie: Movie
    var poster_path: String
    
    init(movie: Movie) {
        self.id = UUID().uuidString
        self.show = false
        self.movie = movie
        self.poster_path = "\(ConfigReader.imgBaseUrl())\(movie.poster_path ?? "")"
    }
}
