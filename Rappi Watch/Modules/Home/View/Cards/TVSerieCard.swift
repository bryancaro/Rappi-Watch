//
//  TVSerieCard.swift
//  Rappi Watch
//
//  Created by Bryan Caro on 10/29/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct TVSerieCard: View {
    @StateObject var detailViewModel = TVSerieViewModel()
    @Binding var viewModel: TVSerieModel
    @Binding var active: Bool
    @Binding var activeIndex: Int
    @Binding var activeView: CGSize
    @Binding var isScrollable: Bool
    
    var bounds: GeometryProxy
    var index: Int
    
    var body: some View {
        ZStack(alignment: .top) {
            WhiteSpace
            
            VisualCard
            
            if isScrollable {
                TVSerieDetailsView(detailViewModel: detailViewModel, viewModel: viewModel, show: $viewModel.show, active: $active, activeIndex: $activeIndex, isScrollable: $isScrollable, bounds: bounds)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
                    .animation(nil)
                    .transition(.opacity)
            }
        }
        .frame(height: viewModel.show ? screen.height : screen.height * 0.4)
        .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
        .edgesIgnoringSafeArea(.all)
    }
    
    // MARK: - Properties
    var cornerRadius: Double {
        return viewModel.show ? getCardCornerRadius(bounds: bounds) : 30
    }
    
    // MARK: - Actions
    func onTapGesture() {
        impact(style: .heavy)
        print(viewModel.serie.id)
        viewModel.show.toggle()
        active.toggle()
        if viewModel.show {
            activeIndex = index
            detailViewModel.fetchDetail(id: viewModel.serie.id)
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
        .frame(maxWidth: CGFloat(viewModel.show ? .infinity : screen.width - 60), maxHeight: CGFloat(viewModel.show ? .infinity : 280.0), alignment: .top)
        .offset(y: viewModel.show ? 460 : 0)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: viewModel.show ? getCardCornerRadius(bounds: bounds) : 30, style: .continuous))
        .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 20)
        .opacity(viewModel.show ? 1 : 0)
    }
    
    var VisualCard: some View {
        VStack {
            ZStack(alignment: .bottom) {
                WebImage(url: URL(string: viewModel.poster_path))
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
                    .opacity(viewModel.show ? 0 : 1)
                
                HStack {
                    VStack(alignment: .leading) {
                        Text(viewModel.serie.name)
                            .font(.title3)
                            .bold()
                        
                        Text(viewModel.serie.firstAirDate)
                            .font(.body)
                    }
                    .foregroundColor(.white)
                    
                    Spacer()
                    
                    RingView(textColor: .white, width: 40, height: 40, percent: viewModel.serie.voteAverage * 10)
                }
                .padding(10)
                .frame(width: screen.width - 145)
                .opacity(viewModel.show ? 0 : 1)
            }
        }
        .frame(maxWidth: viewModel.show ? screen.width : screen.width - 145, maxHeight: viewModel.show ? screen.height * 0.4 : screen.width - 145)
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .shadow(color: Color.black.opacity(0.25), radius: 10, x: 0.0, y: 30)
        .padding(.bottom)
        .onTapGesture(perform: onTapGesture)
    }
    
}

struct TVSerieCard_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { bounds in
            TVSerieCard(viewModel: .constant(TVSerieModel(serie: emptyTVSerie)), active: .constant(false), activeIndex: .constant(0), activeView: .constant(CGSize(width: 0, height: 0)), isScrollable: .constant(true), bounds: bounds, index: 0)
        }
    }
}
