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
    
    var body: some View {
        GeometryReader { bounds in
            ZStack {
                Color.white
                    .animation(.linear)
                    .edgesIgnoringSafeArea(.all)
                
                if showHomeView {
                    VStack {
                        if !active {
                            HeaderView(searchText: $searchText, text: .constant("search_cover_title".localized), onEditingChanged: onEditingChanged, onCommit: onCommit)
                                .padding(.top, 40)
                                .transition(.move(edge: .top))
                        }
                        
                        HStack(alignment: .top) {
                            if !active {
                                SideButtonsView(viewModel: viewModel)
                                    .transition(.move(edge: .leading))
                            }
                            
                            ZStack(alignment: .trailing) {
                                if !active {
                                    Color.white
                                        .frame(width: screen.width * 0.75)
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0.0, y: 0.0)
                                        .scaleEffect(0.97)
                                        .offset(x: -15)
                                        .transition(.move(edge: .trailing))
                                }
                                
                                ScrollView {
                                    VStack {
                                        if !active {
                                            HStack {
                                                Text(viewModel.activeCategory.description)
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
                                            switch viewModel.activeType {
                                            case .movies:
                                                if !viewModel.movies.isEmpty {
                                                    ForEach(commitSearch.isEmpty ? viewModel.movies.indices : searchMovies.indices, id: \.self) { index in
                                                        GeometryReader { geometry in
                                                            MovieCard(
                                                                viewModel: commitSearch.isEmpty ? $viewModel.movies[index] : $searchMovies[index],
                                                                active: $active,
                                                                activeIndex: $activeIndex,
                                                                activeView: $activeView,
                                                                isScrollable: $isScrollable,
                                                                bounds: bounds,
                                                                index: index,
                                                                showAlert: showAlert)
                                                                .offset(y: (commitSearch.isEmpty ? viewModel.movies[index].show : searchMovies[index].show) ? -geometry.frame(in: .global).minY : 0)
                                                                .opacity(activeIndex != index && active ? 0 : 1)
                                                                .scaleEffect(activeIndex != index && active ? 0.5 : 1)
                                                                .offset(x: activeIndex != index && active ? screen.width : 0)
                                                        }
                                                        .frame(height: screen.width * 0.75)
                                                        .frame(maxWidth: (commitSearch.isEmpty ? viewModel.movies[index].show : searchMovies[index].show) ? .infinity :  screen.width - 145)
                                                        .zIndex((commitSearch.isEmpty ? viewModel.movies[index].show : searchMovies[index].show) ? 1 : 0)
                                                    }
                                                    
                                                    if !commitSearch.isEmpty && searchMovies.isEmpty {
                                                        LoadingView(title: "no_found_title".localized, name: "not_found")
                                                            .transition(.fade)
                                                    }
                                                    LoadMoreButton(active: .constant(true), action: moreButtonMoviesTapped)
                                                        .padding()
                                                } else {
                                                    LoadingView(title: "no_found_title".localized, name: "not_found")
                                                        .transition(.fade)
                                                }
                                            case .tvSeries:
                                                if !viewModel.series.isEmpty {
                                                    ForEach(commitSearch.isEmpty ? viewModel.series.indices : searchTVSeries.indices, id: \.self) { index in
                                                        GeometryReader { geometry in
                                                            TVSerieCard(
                                                                viewModel: commitSearch.isEmpty ? $viewModel.series[index] : $searchTVSeries[index],
                                                                active: $active,
                                                                activeIndex: $activeIndex,
                                                                activeView: $activeView,
                                                                isScrollable: $isScrollable,
                                                                bounds: bounds,
                                                                index: index,
                                                                showAlert: showAlert)
                                                                .offset(y: (commitSearch.isEmpty ? viewModel.series[index].show : searchTVSeries[index].show) ? -geometry.frame(in: .global).minY : 0)
                                                                .opacity(activeIndex != index && active ? 0 : 1)
                                                                .scaleEffect(activeIndex != index && active ? 0.5 : 1)
                                                                .offset(x: activeIndex != index && active ? screen.width : 0)
                                                        }
                                                        .frame(height: screen.width * 0.75)
                                                        .frame(maxWidth: (commitSearch.isEmpty ? viewModel.series[index].show : searchTVSeries[index].show) ? .infinity :  screen.width - 145)
                                                        .zIndex((commitSearch.isEmpty ? viewModel.series[index].show : searchTVSeries[index].show) ? 1 : 0)
                                                    }
                                                    
                                                    LoadMoreButton(active: .constant(true), action: moreButtonMoviesTapped)
                                                        .padding()
                                                } else {
                                                    LoadingView(title: "No found", name: "not_found")
                                                        .transition(.fade)
                                                }
                                            }
                                        }
                                    }
                                    .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
                                    .frame(maxWidth: active ? .infinity : screen.width * 0.75)
                                }
                                .statusBar(hidden: active ? true : false)
                                .animation(.interactiveSpring())
                                .disabled(active && !isScrollable ? true : false)
                                .frame(maxWidth: active ? .infinity : screen.width * 0.75)
                                .background(Color.white)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0.0, y: 0.0)
                            }
                        }
                        
                        Spacer()
                    }
                    .frame(maxWidth: active ? .infinity : screen.width)
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
            .sheet(isPresented: $showMySelf, content: {
                MeView(action: hideAppPresent)
            })
        }
    }
    
    // MARK: - Properties
    @State var searchMovies = [MovieModel]()
    @State var searchTVSeries = [TVSerieModel]()
    
    @Binding var showHomeView: Bool
    @State var showMySelf = false
    
    @State var searchText = ""
    @State var commitSearch = ""
    
    @State var active = false
    @State var activeIndex = -1
    @State var activeView = CGSize.zero
    @State var isScrollable = false
    
    // MARK: - Actions
    func onAppear() {
        viewModel.fetchPopularMovies()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            showMySelf = true
        }
    }
    
    func hideAppPresent() {
        haptic(type: .success)
        showMySelf = false
    }
    
    func moreButtonMoviesTapped() {
        viewModel.fetchMore()
    }
    
    func onEditingChanged(changed: Bool) {
    }
    
    func onCommit() {
        commitSearch = searchText
        switch viewModel.activeType {
        case .movies:
            searchMovies = viewModel.movies.filter({$0.movie.title.contains(searchText)})
        case .tvSeries:
            searchTVSeries = viewModel.series.filter({$0.serie.name.contains(searchText)})
        }
    }
    
    func showAlert() {
        viewModel.showAlert(mssg: "This is a demo application, please request the full version")
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(showHomeView: .constant(true))
    }
}
