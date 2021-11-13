//
//  MovieCard.swift
//  Rappi Watch
//
//  Created by Bryan Caro on 10/28/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct MovieCard: View {
    @StateObject var detailViewModel = MovieViewModel()
    @Binding var viewModel: [MovieModel]
    @Binding var active: Bool
    @Binding var activeIndex: Int
    @Binding var activeView: CGSize
    @Binding var isScrollable: Bool
    
    var bodyWidth: CGFloat
    var topInset: CGFloat
    var index: Int
    var showAlert: () -> Void
    
    private let reachability = ReachabilityManager()
    
    var body: some View {
        if viewModel.indices.contains(index) {
            ZStack(alignment: .top) {
                WhiteSpace
                
                VisualCard
                
                if isScrollable {
                    MovieDetailsView(detailViewModel: detailViewModel, viewModel: viewModel[index], show: $viewModel[index].show, active: $active, activeIndex: $activeIndex, isScrollable: $isScrollable, bodyWidth: bodyWidth, topInset: topInset)
                        .background(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
                        .animation(nil)
                        .transition(.opacity)
                }
            }
            .frame(height: viewModel[index].show ? screen.height : screen.height * 0.4)
            .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
            .edgesIgnoringSafeArea(.all)
        }
    }
    
    // MARK: - Properties
    var cornerRadius: Double {
        return viewModel[index].show ? getCardCornerRadius2(bodyWidth: bodyWidth, topInset: topInset) : 30
    }
    
    // MARK: - Actions
    func onTapGesture() {
        impact(style: .heavy)
        viewModel[index].show.toggle()
        active.toggle()
        if viewModel[index].show {
            activeIndex = index
            if reachability.isConnected() {
                detailViewModel.fetchDetail(id: viewModel[index].movie.id)
            }
        } else {
            activeIndex = -1
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
            isScrollable = true
        }
    }
    
    // MARK: - Subviews
    var WhiteSpace: some View {
        VStack(alignment: .leading, spacing: 30.0) {
            Spacer()
        }
        .padding(30)
        .frame(maxWidth: CGFloat(viewModel[index].show ? .infinity : screen.width - 60), maxHeight: CGFloat(viewModel[index].show ? .infinity : 280.0), alignment: .top)
        .offset(y: viewModel[index].show ? 460 : 0)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: viewModel[index].show ? getCardCornerRadius2(bodyWidth: bodyWidth, topInset: topInset) : 30, style: .continuous))
        .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 20)
        .opacity(viewModel[index].show ? 1 : 0)
    }
    
    var VisualCard: some View {
        VStack {
            ZStack(alignment: .bottom) {
                WebImage(url: URL(string: "\(ConfigReader.imgBaseUrl())\(viewModel[index].movie.posterPath ?? "")"))
                    .resizable()
                    .placeholder {
                        Image("logo_rappi")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                    }
                    .transition(.fade(duration: 0.5))
                    .aspectRatio(contentMode: .fill)
                    .frame(width: screen.width - 145, height: (screen.width - 145))
                
                LinearGradient(gradient: Gradient(colors: [Color.black.opacity(0), .black]), startPoint: .top, endPoint: .bottom)
                    .frame(width: screen.width - 145, height: (screen.width - 145)/1.5, alignment: .center)
                    .opacity(viewModel[index].show ? 0 : 1)
                
                HStack {
                    VStack(alignment: .leading) {
                        Text(viewModel[index].movie.title)
                            .font(.title3)
                            .bold()
                        
                        Text(viewModel[index].movie.releaseDate)
                            .font(.body)
                    }
                    .foregroundColor(.white)
                    
                    Spacer()
                    
                    RingView(textColor: .white, width: 40, height: 40, percent: viewModel[index].movie.voteAverage * 10)
                }
                .padding(10)
                .frame(width: screen.width - 145)
                .opacity(viewModel[index].show ? 0 : 1)
            }
        }
        .frame(maxWidth: viewModel[index].show ? screen.width : screen.width - 145, maxHeight: viewModel[index].show ? screen.height * 0.4 : screen.width - 145)
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .shadow(color: Color.black.opacity(0.25), radius: 10, x: 0.0, y: 30)
        .padding(.bottom)
        .onTapGesture(perform: onTapGesture)
    }
}

//struct MovieCard_Previews: PreviewProvider {
//    static var previews: some View {
//        GeometryReader { bounds in
//            MovieCard(viewModel: .constant([MovieModel(movie: emptyMovie))], active: .constant(false), activeIndex: .constant(0), activeView: .constant(CGSize(width: 0, height: 0)), isScrollable: .constant(true), bounds: bounds, index: 0, showAlert: {})
//        }
//    }
//}
