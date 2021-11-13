//
//  TVSeriesView.swift
//  Rappi Watch
//
//  Created by Bryan Caro on 11/10/21.
//

import SwiftUI

struct TVSeriesView: View {
    @ObservedObject var viewModel: HomeViewModel
    
    var body: some View {
        if !viewModel.series.isEmpty {
            ForEach(viewModel.commitSearch.isEmpty ? viewModel.series.indices : viewModel.searchTVSeries.indices, id: \.self) { index in
                GeometryReader { geometry in
                    TVSerieCard(
                        viewModel: viewModel.commitSearch.isEmpty ? $viewModel.series : $viewModel.searchTVSeries,
                        active: $viewModel.active,
                        activeIndex: $viewModel.activeIndex,
                        activeView: $viewModel.activeView,
                        isScrollable: $viewModel.isScrollable,
                        bodyWidth: viewModel.bodyWidth,
                        topInset: viewModel.topInset,
                        index: index)
                        .offset(y: (viewModel.commitSearch.isEmpty ? viewModel.series[index].show : viewModel.searchTVSeries[index].show) ? -geometry.frame(in: .global).minY : 0)
                        .opacity(viewModel.activeIndex != index && viewModel.active ? 0 : 1)
                        .scaleEffect(viewModel.activeIndex != index && viewModel.active ? 0.5 : 1)
                        .offset(x: viewModel.activeIndex != index && viewModel.active ? screen.width : 0)
                }
                .frame(height: screen.width * 0.75)
                .frame(maxWidth: (viewModel.commitSearch.isEmpty ? viewModel.series[index].show : viewModel.searchTVSeries[index].show) ? .infinity :  screen.width - 145)
                .zIndex((viewModel.commitSearch.isEmpty ? viewModel.series[index].show : viewModel.searchTVSeries[index].show) ? 1 : 0)
            }
            
            LoadMoreButton(active: .constant(true), action: loadMoreTapped)
                .padding()
        } else {
            LoadingView(title: "No found", name: "not_found")
                .transition(.fade)
        }
    }
    
    // MARK: - Actions
    func loadMoreTapped() {
        viewModel.fetchMoreTVSeries()
    }
}

struct TVSeriesView_Previews: PreviewProvider {
    static var previews: some View {
        TVSeriesView(viewModel: HomeViewModel())
    }
}
