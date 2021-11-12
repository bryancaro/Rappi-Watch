//
//  HomeViewModel.swift
//  Rappi Watch
//
//  Created by Bryan Caro on 10/30/21.
//

import Foundation
import SwiftUI
import Combine

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
    
    //
    
    
    @Published var searchMovies: [MovieModel] = [MovieModel]()
    @Published var searchTVSeries: [TVSerieModel] = [TVSerieModel]()
    
    @Published var showMySelf = false
    
    @Published var searchText = ""
    @Published var commitSearch = ""
    
    @Published var active = false
    @Published var activeIndex = -1
    @Published var activeView = CGSize.zero
    @Published var isScrollable = false
    
    @Published var bodyWidth: CGFloat = 0
    @Published var topInset: CGFloat = 0
    
    @Published var filterFactory: [FilterModel] = [FilterModel]()
    @Published var filterSelected: [FilterModel] = [FilterModel]()
    private let manageFilters: ManageFilterFactory
    
    //
    
    private let reachability = ReachabilityManager()
    private let repository: HomeRepositoryProtocol
    init(repository: HomeRepositoryProtocol = HomeRepository(), manageFilters: ManageFilterFactory = ManageFilterFactory()) {
        self.repository = repository
        self.manageFilters = manageFilters
    }
    
    // MARK: - Get Filters Manager
    func configureFilter() {
        getFilters {
            ManageFilterFactory.provideFilters()
        }
    }
    
    func getFilters(data: () -> [FilterModel]) {
        self.filterFactory = data()
        self.filterSelected.append(filterFactory[0])
    }
    
    func filterTapped(_ selected: FilterModel) {
        if filterSelected.contains(where: { $0.id == selected.id}) {
            switch activeType {
            case .movies:
                fetchMovies(selected)
            case .tvSeries:
                fetchTVSeries(selected)
            }
        } else {
            filterSelected.removeAll()
            filterSelected.append(selected)
            switch activeType {
            case .movies:
                fetchMovies(selected)
            case .tvSeries:
                fetchTVSeries(selected)
            }
        }
    }
    
    // MARK: - Movies
    func fetchMovies(_ filter: FilterModel) {
        isLoading = true
        actualPage = 1
        totalPage = 0
        repository.fetchMovies(filter, page: actualPage) { [weak self] result, error in
            if let error = error {
                haptic(type: .error)
                dismissLoadingView {
                    self?.isLoading = false
                    self?.appError = AppError(errorString: error.localizedDescription)
                }
                return
            }
            
            guard let result = result else { return }
            self?.actualPage = result.page
            self?.totalPage = result.totalPages
            self?.movies = result.results.map({ MovieModel(movie: $0)})
            
            dismissLoadingView {
                self?.isLoading = false
            }
        }
    }
    
    func fetchMoreMovies() {
        if reachability.isConnected() {
            if actualPage >= totalPage {
                haptic(type: .warning)
            } else {
                actualPage += 1
                repository.fetchMovies(filterSelected[0], page: actualPage) { [weak self] result, error in
                    if let error = error {
                        haptic(type: .error)
                        dismissLoadingView {
                            self?.isLoading = false
                            self?.appError = AppError(errorString: error.localizedDescription)
                        }
                        return
                    }
                    
                    guard let result = result else { return }
                    self?.actualPage = result.page
                    self?.totalPage = result.totalPages
                    self?.movies += result.results.map({ MovieModel(movie: $0)})
                    haptic(type: .success)
                }
            }
        } else {
            haptic(type: .warning)
        }
    }
    
    // MARK: - TV Series
    func fetchTVSeries(_ filter: FilterModel) {
        isLoading = true
        actualPage = 1
        totalPage = 0
        repository.fetchTVSeries(filter, page: actualPage) { [weak self] result, error in
            if let error = error {
                haptic(type: .error)
                dismissLoadingView {
                    self?.isLoading = false
                    self?.appError = AppError(errorString: error.localizedDescription)
                    self?.series.removeAll()
                }
                return
            }
            
            guard let result = result else { return }
            self?.actualPage = result.page
            self?.totalPage = result.totalPages
            self?.series = result.results.map({ TVSerieModel(serie: $0)})
            
            dismissLoadingView {
                self?.isLoading = false
            }
        }
    }
    
    func fetchMoreTVSeries() {
        if reachability.isConnected() {
            if actualPage >= totalPage {
                haptic(type: .warning)
            } else {
                actualPage += 1
                
                repository.fetchTVSeries(filterSelected[0], page: actualPage) { [weak self] result, error in
                    if let error = error {
                        haptic(type: .error)
                        dismissLoadingView {
                            self?.isLoading = false
                            self?.appError = AppError(errorString: error.localizedDescription)
                            self?.series.removeAll()
                        }
                        return
                    }
                    
                    guard let result = result else { return }
                    self?.actualPage = result.page
                    self?.totalPage = result.totalPages
                    self?.series += result.results.map({ TVSerieModel(serie: $0)})
                    haptic(type: .success)
                }
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

