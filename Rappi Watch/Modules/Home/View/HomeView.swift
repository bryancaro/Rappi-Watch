//
//  HomeView.swift
//  Rappi Watch
//
//  Created by Bryan Caro on 10/28/21.
//

import SwiftUI

struct HomeView: View {
    @Environment(\.colorScheme) var colorScheme
    
    @StateObject var viewModel = HomeViewModel()
    
    @Binding var showHomeView: Bool
    
    var body: some View {
        GeometryReader { bounds in
            ZStack {
                Color.white
                    .animation(.linear)
                    .edgesIgnoringSafeArea(.all)
                
                if showHomeView {
                    VStack {
                        if !viewModel.active {
                            HeaderView(searchText: $viewModel.searchText, text: .constant("search_cover_title".localized), onEditingChanged: onEditingChanged, onCommit: onCommit)
                                .padding(.top, 40)
                                .transition(.move(edge: .top))
                        }
                        
                        HStack(alignment: .top) {
                            if !viewModel.active {
                                SideButtonsView(viewModel: viewModel)
                                    .transition(.move(edge: .leading))
                            }
                            
                            ZStack(alignment: .trailing) {
                                if !viewModel.active {
                                    Color.white
                                        .frame(width: screen.width * 0.75)
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0.0, y: 0.0)
                                        .scaleEffect(0.97)
                                        .offset(x: -15)
                                        .transition(.move(edge: .trailing))
                                }
                                
                                ScrollContentView(viewModel: viewModel)
                                    .bindGeometry(to: $viewModel.bodyWidth, reader: { $0.size.width })
                                    .bindSafeAreaInset(of: .top, to: $viewModel.topInset)
                            }
                        }
                        
                        Spacer()
                    }
                    .frame(maxWidth: viewModel.active ? .infinity : screen.width)
                    .edgesIgnoringSafeArea(.all)
                    .onAppear(perform: onAppear)
                    .alert(item: $viewModel.appError) { appAlert in
                        Alert(title: Text("Error"),
                              message: Text("\(appAlert.errorString)"),
                              dismissButton: .default(Text("OK"))
                        )
                    }
                }
            }
            .onChange(of: viewModel.searchText) {
                print($0)
                searchBox()
            }
            .sheet(isPresented: $viewModel.showMySelf, content: {
                MeView(action: hideAppPresent)
            })
        }
    }
    
    // MARK: - Properties
    
    
    // MARK: - Actions
    func onAppear() {
        viewModel.configureCategories()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            viewModel.showMySelf = true
        }
    }
    
    func hideAppPresent() {
        haptic(type: .success)
        viewModel.showMySelf = false
    }
    
    func onEditingChanged(changed: Bool) {}
    
    func searchBox() {
        viewModel.commitSearch = viewModel.searchText.lowercased()
        
        switch viewModel.categoriesSelected[0].category.active {
        case .movies:
            viewModel.searchMovies = viewModel.movies.filter({$0.movie.title.lowercased().contains(viewModel.searchText.lowercased())})
        case .tvshow:
            viewModel.searchTVSeries = viewModel.series.filter({$0.serie.name.lowercased().contains(viewModel.searchText.lowercased())})
        case .people:
            viewModel.searchPeople = viewModel.people.filter({$0.people.name.lowercased().contains(viewModel.searchText.lowercased())})
        }
    }
    
    func onCommit() {}
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(showHomeView: .constant(true))
    }
}
