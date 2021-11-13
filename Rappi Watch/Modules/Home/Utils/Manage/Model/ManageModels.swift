//
//  ManageModels.swift
//  Rappi Watch
//
//  Created by Bryan Caro on 11/13/21.
//

import Foundation

struct CategoriesModel: Identifiable {
    var id: String
    var category: CategoriesProtocol
    
    init(_ category: CategoriesProtocol) {
        self.id = UUID().uuidString
        self.category = category
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
