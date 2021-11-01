//
//  HomeViewModel.swift
//  Rappi Watch
//
//  Created by Bryan Caro on 10/30/21.
//

import Foundation
import Combine

enum SideButtonTypeState: CustomStringConvertible {
    case movies
    case tvSeries
    
    init() {
        self = .movies
    }
    
    var description: String {
        switch self {
        case .movies:
            return "Movies"
        case .tvSeries:
            return "TV Series"
        }
    }
}

enum SideButtonCategoryState: CustomStringConvertible {
    case popular
    case topRated
    case upcoming
    
    init() {
        self = .popular
    }
    
    var description: String {
        switch self {
        case .popular:
            return "Popular"
        case .topRated:
            return "Top-Rated"
        case .upcoming:
            return "Up-Coming"
        }
    }
}

class HomeViewModel: ObservableObject {
    struct AppError: Identifiable {
        let id = UUID().uuidString
        let errorString: String
    }
    @Published var appError  : AppError? = nil
    @Published var isLoading : Bool = true
    
    @Published var activeType: SideButtonTypeState = SideButtonTypeState()
    @Published var activeCategory: SideButtonCategoryState = SideButtonCategoryState()
    
    @Published var movies: [MovieModel] = [MovieModel]()
    @Published var series: [TVSerieModel] = [TVSerieModel]()
    
    @Published var actualPage: Int = 1
    @Published var totalPage: Int = 0
    
    private let reachability = ReachabilityManager()
    private let repository: HomeRepositoryProtocol
    init(repository: HomeRepositoryProtocol = HomeRepository()) {
        self.repository = repository
    }
    
    // MARK: - Fetch More
    func fetchMore() {
        switch activeType {
        case .movies:
            switch activeCategory {
            case .popular:
                fetchMorePopularMovies()
            case .topRated:
                fetchMoreTopRatedMovies()
            case .upcoming:
                fetchMoreUpComingMovies()
            }
            
        case .tvSeries:
            switch activeCategory {
            case .popular:
                fetchMorePopularTVSeries()
            case .topRated:
                fetchMoreTopRatedTVSeries()
            case .upcoming:
                haptic(type: .warning)
            }
        }
    }
    
    // MARK: - Movies
    func fetchPopularMovies() {
        isLoading = true
        actualPage = 1
        totalPage = 0
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
            self.actualPage = popularMovies.page
            self.totalPage = popularMovies.totalPages
            self.movies = popularMovies.results.map({ MovieModel(movie: $0)})
            
            dismissLoadingView {
                self.isLoading = false
            }
        })
    }
    
    func fetchMorePopularMovies() {
        if !reachability.isConnected() {
            if actualPage >= totalPage {
                haptic(type: .warning)
                print("Button desactivated")
            } else {
                actualPage += 1
                repository.fetchPopularMovies(page: actualPage, completion: { popularMovies, error in
                    if let error = error {
                        haptic(type: .error)
                        dismissLoadingView {
                            self.appError = AppError(errorString: error.localizedDescription)
                        }
                        return
                    }
                    
                    guard let popularMovies = popularMovies else { return }
                    self.actualPage = popularMovies.page
                    self.totalPage = popularMovies.totalPages
                    self.movies += popularMovies.results.map({ MovieModel(movie: $0)})
                    haptic(type: .success)
                })
            }
        } else {
            haptic(type: .warning)
        }
    }
    
    func fetchTopRatedMovies() {
        isLoading = true
        actualPage = 1
        totalPage = 0
        repository.fetchTopRatedMovies(page: actualPage, completion: { topRatedMovies, error in
            if let error = error {
                haptic(type: .error)
                dismissLoadingView {
                    self.isLoading = false
                    self.appError = AppError(errorString: error.localizedDescription)
                }
                return
            }
            
            guard let topRatedMovies = topRatedMovies else { return }
            self.actualPage = topRatedMovies.page
            self.totalPage = topRatedMovies.totalPages
            self.movies = topRatedMovies.results.map({ MovieModel(movie: $0)})
            
            dismissLoadingView {
                self.isLoading = false
            }
        })
    }
    
    func fetchMoreTopRatedMovies() {
        if !reachability.isConnected() {
            if actualPage >= totalPage {
                haptic(type: .warning)
                print("Button desactivated")
            } else {
                actualPage += 1
                repository.fetchTopRatedMovies(page: actualPage, completion: { topRatedMovies, error in
                    if let error = error {
                        haptic(type: .error)
                        dismissLoadingView {
                            self.appError = AppError(errorString: error.localizedDescription)
                        }
                        return
                    }
                    
                    guard let topRatedMovies = topRatedMovies else { return }
                    self.actualPage = topRatedMovies.page
                    self.totalPage = topRatedMovies.totalPages
                    self.movies += topRatedMovies.results.map({ MovieModel(movie: $0)})
                    haptic(type: .success)
                })
            }
        } else {
            haptic(type: .warning)
        }
    }
    
    func fetchUpComingMovies() {
        isLoading = true
        actualPage = 1
        totalPage = 0
        repository.fetchUpComingMovies(page: actualPage, completion: { upComingMovies, error in
            if let error = error {
                haptic(type: .error)
                dismissLoadingView {
                    self.isLoading = false
                    self.appError = AppError(errorString: error.localizedDescription)
                }
                return
            }
            
            guard let upComingMovies = upComingMovies else { return }
            self.actualPage = upComingMovies.page
            self.totalPage = upComingMovies.totalPages
            
            dismissLoadingView {
                self.movies = upComingMovies.results.map({ MovieModel(movie: $0)})
                self.isLoading = false
            }
        })
    }
    
    func fetchMoreUpComingMovies() {
        if !reachability.isConnected() {
            if actualPage >= totalPage {
                haptic(type: .warning)
                print("Button desactivated")
            } else {
                actualPage += 1
                repository.fetchUpComingMovies(page: actualPage, completion: { upComingMovies, error in
                    if let error = error {
                        haptic(type: .error)
                        dismissLoadingView {
                            self.appError = AppError(errorString: error.localizedDescription)
                        }
                        return
                    }
                    
                    guard let upComingMovies = upComingMovies else { return }
                    self.actualPage = upComingMovies.page
                    self.totalPage = upComingMovies.totalPages
                    self.movies += upComingMovies.results.map({ MovieModel(movie: $0)})
                    haptic(type: .success)
                })
            }
        } else {
            haptic(type: .warning)
        }
    }
    
    // MARK: - TV Series
    func fetchPopularTVSeries() {
        isLoading = true
        repository.fetchPopularTVSeries(page: actualPage) { popular, error in
            if let error = error {
                haptic(type: .error)
                dismissLoadingView {
                    self.isLoading = false
                    self.appError = AppError(errorString: error.localizedDescription)
                }
                return
            }
            
            guard let popular = popular else { return }
            self.series = popular.results.map({ TVSerieModel(serie: $0)})
            
            dismissLoadingView {
                self.isLoading = false
            }
        }
    }
    
    func fetchMorePopularTVSeries() {
        if !reachability.isConnected() {
            if actualPage >= totalPage {
                haptic(type: .warning)
                print("Button desactivated")
            } else {
                actualPage += 1
                repository.fetchPopularTVSeries(page: actualPage, completion: { popular, error in
                    if let error = error {
                        haptic(type: .error)
                        dismissLoadingView {
                            self.appError = AppError(errorString: error.localizedDescription)
                        }
                        return
                    }
                    
                    guard let popular = popular else { return }
                    self.actualPage = popular.page
                    self.totalPage = popular.totalPages
                    self.series += popular.results.map({ TVSerieModel(serie: $0)})
                    haptic(type: .success)
                })
            }
        } else {
            haptic(type: .warning)
        }
    }
    
    func fetchTopRatedTVSeries() {
        isLoading = true
        repository.fetchTopRatedTVSeries(page: actualPage) { popular, error in
            if let error = error {
                haptic(type: .error)
                dismissLoadingView {
                    self.isLoading = false
                    self.appError = AppError(errorString: error.localizedDescription)
                }
                return
            }

            guard let popular = popular else { return }
            self.series = popular.results.map({ TVSerieModel(serie: $0)})

            dismissLoadingView {
                self.isLoading = false
            }
        }
    }
    
    func fetchMoreTopRatedTVSeries() {
        if !reachability.isConnected() {
            if actualPage >= totalPage {
                haptic(type: .warning)
                print("Button desactivated")
            } else {
                actualPage += 1
                repository.fetchTopRatedTVSeries(page: actualPage, completion: { popular, error in
                    if let error = error {
                        haptic(type: .error)
                        dismissLoadingView {
                            self.appError = AppError(errorString: error.localizedDescription)
                        }
                        return
                    }
                    
                    guard let popular = popular else { return }
                    self.actualPage = popular.page
                    self.totalPage = popular.totalPages
                    self.series += popular.results.map({ TVSerieModel(serie: $0)})
                    haptic(type: .success)
                })
            }
        } else {
            haptic(type: .warning)
        }
    }
    
    func showAlert(mssg: String) {
        appError = AppError(errorString: mssg)
    }
}

struct MovieModel: Identifiable, Hashable {
    var id: String
    var show: Bool
    var movie: Movie
    
    init(movie: Movie) {
        self.id = UUID().uuidString
        self.show = false
        self.movie = movie
    }
}

struct TVSerieModel: Identifiable, Hashable {
    var id: String
    var show: Bool
    var serie: TVSerie
    var poster_path: String

    init(serie: TVSerie) {
        self.id = UUID().uuidString
        self.show = false
        self.serie = serie
        self.poster_path = "\(ConfigReader.imgBaseUrl())\(serie.posterPath ?? "")"
    }
}
