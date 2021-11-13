//
//  ScrollContentView.swift
//  Rappi Watch
//
//  Created by Bryan Caro on 11/10/21.
//

import SwiftUI

struct ScrollContentView: View {
    @ObservedObject var viewModel: HomeViewModel
    
    var body: some View {
        ScrollView {
            VStack {
                if !viewModel.active {
                    HStack {
                        Text(viewModel.filterSelected.isEmpty ? "Loading" : viewModel.filterSelected[0].filter.title)
                            .font(.body)
                            .bold()
                        
                        Spacer()
                    }
                    .padding()
                }
                
                if viewModel.isLoading {
                    LoadingView(title: "loading_title".localized, name: "loading")
                        .transition(.fade)
                } else {
                    switch viewModel.categoriesSelected[0].category.active {
                    case .movies:
                        MoviesView(viewModel: viewModel)
                    case .tvshow:
                        TVSeriesView(viewModel: viewModel)
                    case .people:
                        PeopleView(viewModel: viewModel)
                    }
                }
            }
            .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
            .frame(maxWidth: viewModel.active ? .infinity : screen.width * 0.75)
        }
        .statusBar(hidden: viewModel.active ? true : false)
        .animation(.interactiveSpring())
        .disabled(viewModel.active && !viewModel.isScrollable ? true : false)
        .frame(maxWidth: viewModel.active ? .infinity : screen.width * 0.75)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0.0, y: 0.0)
    }
}

struct ScrollContentView_Previews: PreviewProvider {
    static var previews: some View {
        ScrollContentView(viewModel: HomeViewModel())
    }
}
