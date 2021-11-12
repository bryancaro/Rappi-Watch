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
                .accessibilityIdentifier("movieCategoryButton")
            
            CustomButtonType(get: $viewModel.activeType, set: .tvSeries, image: "play.tv.fill", action: typeAction)
                .accessibilityIdentifier("tvSerieCategoryButton")
            
            Text("sideButton_title".localized)
                .font(.footnote)
                .bold()
                .padding(.top)
            
            if !viewModel.filterFactory.isEmpty {
                ForEach(viewModel.filterFactory.indices) { index in
                    CustomButtonCategory(selected: $viewModel.filterSelected,
                                         id: viewModel.filterFactory[index].id,
                                         image: viewModel.filterFactory[index].filter.image,
                                         action: { categoryTapped(viewModel.filterFactory[index]) })
                }
            }
        }
        .frame(maxWidth: 100)
    }
        
    // MARK: - Actions
    func typeAction(select: SideButtonTypeState) {
        viewModel.activeType = select
        viewModel.filterTapped(viewModel.filterSelected[0])
    }
    
    func categoryTapped(_ selected: FilterModel) {
        viewModel.filterTapped(selected)
    }
    
//    func categoryAction(selet: SideButtonCategoryState) {
//        viewModel.activeCategory = selet
//
//        switch selet {
//        case .popular:
//            switch viewModel.activeType {
//            case .movies:
//                viewModel.fetchPopularMovies()
//            case .tvSeries:
//                viewModel.fetchPopularTVSeries()
//            }
//
//        case .topRated:
//            switch viewModel.activeType {
//            case .movies:
//                viewModel.fetchTopRatedMovies()
//            case .tvSeries:
//                viewModel.fetchTopRatedTVSeries()
//            }
//
//        case .upcoming:
//            switch viewModel.activeType {
//            case .movies:
//                viewModel.fetchUpComingMovies()
//            case .tvSeries:
//                viewModel.isLoading = true
//
//                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//                    self.viewModel.series.removeAll()
//                    self.viewModel.isLoading = false
//                }
//            }
//        }
//    }
}

struct SideButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        SideButtonsView(viewModel: HomeViewModel())
    }
}
