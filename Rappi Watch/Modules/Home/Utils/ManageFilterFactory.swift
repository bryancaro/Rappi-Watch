//
//  ManageFilterFactory.swift
//  Rappi Watch
//
//  Created by Bryan Caro on 11/11/21.
//

import Foundation

protocol FilterProtocol {
    var title: String { get }
    var image: String { get }
    var endpoint: String { get }
    var type: SideButtonCategoryState { get }
}

struct ManageFilterFactory {
    enum Filter: FilterProtocol {
        case popular
        case topRated
        case upcoming
        
        var title: String {
            switch self {
            case .popular:
                return "filter_button_first_title".localized
            case .topRated:
                return "filter_button_second_title".localized
            case .upcoming:
                return "filter_button_third_title".localized
            }
        }
        
        var image: String {
            switch self {
            case .popular:
                return "heart.fill"
            case .topRated:
                return "flame.fill"
            case .upcoming:
                return "calendar.badge.clock"
            }
        }
        
        var endpoint: String {
            switch self {
            case .popular:
                return "/popular"
            case .topRated:
                return "/top_rated"
            case .upcoming:
                return "/upcoming"
            }
        }
        
        var type: SideButtonCategoryState {
            switch self {
            case .popular:
                return .popular
            case .topRated:
                return .topRated
            case .upcoming:
                return .upcoming
            }
        }
    }
    
    static func provideFilters() -> [FilterModel] {
        [
            FilterModel(Filter.popular),
            FilterModel(Filter.topRated),
            FilterModel(Filter.upcoming)
        ]
    }
}

struct FilterModel: Identifiable {
    var id: String
    var filter: FilterProtocol
    
    init(_ filter: FilterProtocol) {
        self.id = UUID().uuidString
        self.filter = filter
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
