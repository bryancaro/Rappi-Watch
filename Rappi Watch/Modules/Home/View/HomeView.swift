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
    
    //
    @Binding var showHomeView: Bool
    @State var showMySelf = false
    
    // Header View
    @State var searchText = ""
    @State var text = "What movie are you looking for?"
    
    @State var categoryTitle = "Top Rated"
    
    // Card movie data
    @State var active = false
    @State var activeIndex = -1
    @State var activeView = CGSize.zero
    @State var isScrollable = false
    
    
    @State var data = courseData
    
    @State var switchCard = false
    
    var body: some View {
        GeometryReader { bounds in
            ZStack {
                Color.white
                    .animation(.linear)
                    .edgesIgnoringSafeArea(.all)
                
                if showHomeView {
                    VStack {
                        if !active {
                            HeaderView(searchText: $searchText, text: $text, onEditingChanged: onEditingChanged, onCommit: onCommit)
                                .padding(.top, 40)
                                .transition(.move(edge: .top))
                        }
                        
                        HStack(alignment: .top) {
                            if !active {
                                SideButtonsView(switchCard: $switchCard)
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
                                                Text(categoryTitle)
                                                    .font(.body)
                                                    .bold()
                                                
                                                Spacer()
                                            }
                                            .padding()
                                        }
                                        
                                        ForEach(viewModel.movies.indices, id: \.self) { index in
                                            GeometryReader { geometry in
//                                                if switchCard {
                                                    MovieCard(
                                                        viewModel: $viewModel.movies[index],
                                                        show: $viewModel.movies[index].show,
                                                        active: $active,
                                                        activeIndex: $activeIndex,
                                                        activeView: $activeView,
                                                        isScrollable: $isScrollable,
                                                        bounds: bounds,
                                                        index: index)
                                                        .offset(y: viewModel.movies[index].show ? -geometry.frame(in: .global).minY : 0)
                                                        .opacity(activeIndex != index && active ? 0 : 1)
                                                        .scaleEffect(activeIndex != index && active ? 0.5 : 1)
                                                        .offset(x: activeIndex != index && active ? screen.width : 0)
//                                                }
//                                                else {
//                                                    TVSerieCard(
//                                                        show: $data[index].show,
//                                                        active: $active,
//                                                        activeIndex: $activeIndex,
//                                                        activeView: $activeView,
//                                                        isScrollable: $isScrollable,
//                                                        bounds: bounds,
//                                                        index: index)
//                                                        .offset(y: data[index].show ? -geometry.frame(in: .global).minY : 0)
//                                                        .opacity(activeIndex != index && active ? 0 : 1)
//                                                        .scaleEffect(activeIndex != index && active ? 0.5 : 1)
//                                                        .offset(x: activeIndex != index && active ? screen.width : 0)
//                                                }
                                                
                                            }
                                            .frame(height: screen.width * 0.75)
                                            .frame(maxWidth: viewModel.movies[index].show ? .infinity :  screen.width - 145)
                                            .zIndex(viewModel.movies[index].show ? 1 : 0)
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
                    .onAppear(perform: {
                        viewModel.fetchPopularMovies()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            showMySelf = true
                        }
                    })
                }
            }
            .sheet(isPresented: $showMySelf, content: {
                MeView(action: hideAppPresent)
            })
        }
    }
    
    // MARK: - Properties
    
    // MARK: - Actions
    func hideAppPresent() {
        haptic(type: .success)
        showMySelf = false
    }
    
    func onEditingChanged(changed: Bool) {
        
    }
    
    
    func onCommit() {
        
    }
    
    // MARK: - Subviews
    
    
    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(showHomeView: .constant(true))
    }
}

struct Course: Identifiable {
    var id = UUID()
    var title: String
    var subtitle: String
    var image: URL
    var logo: UIImage
    var color: UIColor
    var show: Bool
}

var courseData = [
    Course(title: "Prototype Designs in SwiftUI", subtitle: "18 Sections", image: URL(string: "https://dl.dropbox.com/s/pmggyp7j64nvvg8/Certificate%402x.png?dl=0")!, logo: #imageLiteral(resourceName: "me"), color: #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1), show: false),
    Course(title: "SwiftUI Advanced", subtitle: "20 Sections", image: URL(string: "https://dl.dropbox.com/s/i08umta02pa09ns/Card3%402x.png?dl=0")!, logo: #imageLiteral(resourceName: "screen_two"), color: #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1), show: false),
    Course(title: "UI Design for Developers", subtitle: "20 Sections", image: URL(string: "https://dl.dropbox.com/s/etdzsafqqeq0jjg/Card6%402x.png?dl=0")!, logo: #imageLiteral(resourceName: "joker"), color: #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1), show: false)
]
