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
        if !viewModel.categoriesFactory.isEmpty {
            VStack {
                Text(viewModel.categoriesSelected[0].category.title)
                    .font(.footnote)
                    .bold()
                
                if !viewModel.categoriesFactory.isEmpty {
                    ForEach(viewModel.categoriesFactory.indices) { index in
                        CustomButtonCategory(selected: $viewModel.categoriesSelected,
                                             id: viewModel.categoriesFactory[index].id,
                                             image: viewModel.categoriesFactory[index].category.image,
                                             action: { categorieTapped(viewModel.categoriesFactory[index]) })
                    }
                }
                
                Text("sideButton_title".localized)
                    .font(.footnote)
                    .bold()
                    .padding(.top)
                
                if !viewModel.categoriesSelected.isEmpty {
                    ForEach(viewModel.categoriesSelected[0].category.filters.indices, id: \.self) { index in
                        if viewModel.categoriesSelected[0].category.filters.indices.contains(index) {
                            CustomButtonFilter(selected: $viewModel.filterSelected,
                                               id: viewModel.categoriesSelected[0].category.filters[index].id,
                                               image: viewModel.categoriesSelected[0].category.filters[index].filter.image,
                                               action: { filterTapped(viewModel.categoriesSelected[0].category.filters[index]) })
                        }
                    }
                }
            }
            .frame(maxWidth: 100)
        }
    }
    
    // MARK: - Actions
    func categorieTapped(_ selected: CategoriesModel) {
        viewModel.categorieTapped(selected)
    }
    
    func filterTapped(_ selected: FilterModel) {
        viewModel.filterTapped(selected)
    }
}

struct SideButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        SideButtonsView(viewModel: HomeViewModel())
    }
}
