//
//  SideButtonsView.swift
//  Rappi Watch
//
//  Created by Bryan Caro on 10/28/21.
//

import SwiftUI

struct SideButtonsView: View {
    @ObservedObject var viewModel: HomeViewModel
    
    var body: some View {
        VStack {
            Text(viewModel.activeType.description)
                .font(.footnote)
                .bold()
            
            CustomButtonType(get: $viewModel.activeType, set: .movies, image: "film.fill", action: typeAction)
            
            CustomButtonType(get: $viewModel.activeType, set: .tvSeries, image: "play.tv.fill", action: typeAction)
            
            
            Text("Category")
                .font(.footnote)
                .bold()
                .padding(.top)
            
            CustomButtonCategory(get: $viewModel.activeCategory, set: .popular, image: "heart.fill", action: categoryAction)
            
            CustomButtonCategory(get: $viewModel.activeCategory, set: .topRated, image: "flame.fill", action: categoryAction)
            
            CustomButtonCategory(get: $viewModel.activeCategory, set: .upcoming, image: "calendar.badge.clock", action: categoryAction)
        }
        .frame(maxWidth: 100)
    }
    
    // MARK: - Properties
    
    // MARK: - Actions
    func typeAction(select: SideButtonTypeState) {
        viewModel.activeType = select
        categoryAction(selet: viewModel.activeCategory)
    }
    
    func categoryAction(selet: SideButtonCategoryState) {
        viewModel.activeCategory = selet
        
        switch selet {
        case .popular:
            switch viewModel.activeType {
            case .movies:
                viewModel.fetchPopularMovies()
            case .tvSeries:
                viewModel.fetchPopularTVSeries()
            }
            
        case .topRated:
            switch viewModel.activeType {
            case .movies:
                viewModel.fetchTopRatedMovies()
            case .tvSeries:
                viewModel.fetchTopRatedTVSeries()
            }
            
        case .upcoming:
            switch viewModel.activeType {
            case .movies:
                viewModel.fetchUpComingMovies()
            case .tvSeries:
                viewModel.isLoading = true
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.viewModel.series.removeAll()
                    self.viewModel.isLoading = false
                }
            }
            
        }
    }
    
    // MARK: - Subviews
        
}

struct SideButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        SideButtonsView(viewModel: HomeViewModel())
    }
}
