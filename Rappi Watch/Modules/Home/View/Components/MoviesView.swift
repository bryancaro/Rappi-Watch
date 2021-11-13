//
//  MoviesView.swift
//  Rappi Watch
//
//  Created by Bryan Caro on 11/10/21.
//

import SwiftUI

struct MoviesView: View {
    @ObservedObject var viewModel: HomeViewModel
    
    var body: some View {
        if (viewModel.commitSearch.isEmpty && !viewModel.movies.isEmpty) || (!viewModel.commitSearch.isEmpty && !viewModel.searchMovies.isEmpty) {
            ForEach(viewModel.commitSearch.isEmpty ? viewModel.movies.indices : viewModel.searchMovies.indices, id: \.self) { index in
                GeometryReader { geometry in
                    MovieCard(
                        viewModel: viewModel.commitSearch.isEmpty ? $viewModel.movies : $viewModel.searchMovies,
                        active: $viewModel.active,
                        activeIndex: $viewModel.activeIndex,
                        activeView: $viewModel.activeView,
                        isScrollable: $viewModel.isScrollable,
                        bodyWidth: viewModel.bodyWidth,
                        topInset: viewModel.topInset,
                        index: index)
                        .offset(y: (viewModel.commitSearch.isEmpty ? viewModel.movies[index].show : viewModel.searchMovies[index].show) ? -geometry.frame(in: .global).minY : 0)
                        .opacity(viewModel.activeIndex != index && viewModel.active ? 0 : 1)
                        .scaleEffect(viewModel.activeIndex != index && viewModel.active ? 0.5 : 1)
                        .offset(x: viewModel.activeIndex != index && viewModel.active ? screen.width : 0)
                }
                .frame(height: screen.width * 0.75)
                .frame(maxWidth: (viewModel.commitSearch.isEmpty ? viewModel.movies[index].show : viewModel.searchMovies[index].show) ? .infinity :  screen.width - 145)
                .zIndex((viewModel.commitSearch.isEmpty ? viewModel.movies[index].show : viewModel.searchMovies[index].show) ? 1 : 0)
            }
            
            if !viewModel.commitSearch.isEmpty && viewModel.searchMovies.isEmpty {
                LoadingView(title: "no_found_title".localized, name: "not_found")
                    .transition(.fade)
            }
            
            LoadMoreButton(active: .constant(true), action: loadMoreTapped)
                .padding()
        } else {
            LoadingView(title: "no_found_title".localized, name: "not_found")
                .transition(.fade)
        }
    }
    
    // MARK: - Actions
    func loadMoreTapped() {
        viewModel.fetchMoreMovies()
    }
}

struct MoviesView_Previews: PreviewProvider {
    static var previews: some View {
        MoviesView(viewModel: HomeViewModel())
    }
}
