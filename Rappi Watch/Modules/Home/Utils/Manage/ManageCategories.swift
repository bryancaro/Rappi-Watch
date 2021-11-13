//
//  ManageCategories.swift
//  Rappi Watch
//
//  Created by Bryan Caro on 11/12/21.
//

import Foundation
import SwiftUI

enum ActiveCategorie {
    case movies
    case tvshow
    case people
}

enum ActiveFilter: CustomStringConvertible {
    case popular
    case topRated
    case upcoming
    
    var description: String {
        switch self {
        case .popular:
            return "filter_button_first_title".localized
        case .topRated:
            return "filter_button_second_title".localized
        case .upcoming:
            return "filter_button_third_title".localized
        }
    }
}

protocol CategoriesProtocol {
    var title: String { get }
    var image: String { get }
    var filters: [FilterModel] { get }
    var active: ActiveCategorie { get }
}

protocol FilterProtocol {
    var title: String { get }
    var image: String { get }
    var endpoint: String { get }
    var active: ActiveFilter { get }
}

struct ManageCategories {
    enum Categories: CategoriesProtocol {
        case movies
        case tvshow
        case people
        
        var title: String {
            switch self {
            case .movies:
                return "categorie_first_title".localized
            case .tvshow:
                return "categorie_second_title".localized
            case .people:
                return "categorie_third_title".localized
            }
        }
        
        var image: String {
            switch self {
            case .movies:
                return "film.fill"
            case .tvshow:
                return "play.tv.fill"
            case .people:
                return "person.3.fill"
            }
        }
        
        var filters: [FilterModel] {
            switch self {
            case .movies:
                return [
                    FilterModel(Filter.popular),
                    FilterModel(Filter.topRated),
                    FilterModel(Filter.upcoming)
                ]
            case .tvshow:
                return [
                    FilterModel(Filter.popular),
                    FilterModel(Filter.topRated)
                ]
            case .people:
                return [
                    FilterModel(Filter.popular)
                ]
            }
        }
        
        var active: ActiveCategorie {
            switch self {
            case .movies:
                return .movies
            case .tvshow:
                return .tvshow
            case .people:
                return .people
            }
        }
    }
    
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
        
        var active: ActiveFilter {
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

    static func provideCategories() -> [CategoriesModel] {
        [
            CategoriesModel(Categories.movies),
            CategoriesModel(Categories.tvshow),
            CategoriesModel(Categories.people)
        ]
    }
}
