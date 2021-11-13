//
//  PeopleView.swift
//  Rappi Watch
//
//  Created by Bryan Caro on 11/12/21.
//

import SwiftUI

struct PeopleView: View {
    @ObservedObject var viewModel: HomeViewModel
    
    var body: some View {
        if !viewModel.people.isEmpty {
            ForEach(viewModel.commitSearch.isEmpty ? viewModel.people.indices : viewModel.searchPeople.indices, id: \.self) { index in
                GeometryReader { geometry in
                    PeopleCard(
                        viewModel: viewModel.commitSearch.isEmpty ? $viewModel.people : $viewModel.searchPeople,
                        active: $viewModel.active,
                        activeIndex: $viewModel.activeIndex,
                        activeView: $viewModel.activeView,
                        isScrollable: $viewModel.isScrollable,
                        bodyWidth: viewModel.bodyWidth,
                        topInset: viewModel.topInset,
                        index: index,
                        showAlert: showAlert)
                        .offset(y: (viewModel.commitSearch.isEmpty ? viewModel.people[index].show : viewModel.searchPeople[index].show) ? -geometry.frame(in: .global).minY : 0)
                        .opacity(viewModel.activeIndex != index && viewModel.active ? 0 : 1)
                        .scaleEffect(viewModel.activeIndex != index && viewModel.active ? 0.5 : 1)
                        .offset(x: viewModel.activeIndex != index && viewModel.active ? screen.width : 0)
                }
                .frame(height: screen.width * 0.75)
                .frame(maxWidth: (viewModel.commitSearch.isEmpty ? viewModel.people[index].show : viewModel.searchPeople[index].show) ? .infinity :  screen.width - 145)
                .zIndex((viewModel.commitSearch.isEmpty ? viewModel.people[index].show : viewModel.searchPeople[index].show) ? 1 : 0)
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
        viewModel.fetchMorePeople()
    }
    
    func showAlert() {
        viewModel.showAlert(mssg: "beta_version".localized)
    }
}

struct PeopleView_Previews: PreviewProvider {
    static var previews: some View {
        PeopleView(viewModel: HomeViewModel())
    }
}
