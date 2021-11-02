//
//  TVSerieDetailsView.swift
//  Rappi Watch
//
//  Created by Bryan Caro on 10/29/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct TVSerieDetailsView: View {
    @ObservedObject var detailViewModel: TVSerieViewModel
    
    var body: some View {
        ScrollView {
            VStack {
                CloseButton
                
                VStack(spacing: 20) {
                    TopDetailsView(title: viewModel.serie.name, date: viewModel.serie.firstAirDate, rating: viewModel.serie.voteAverage, status: detailViewModel.detail.serie.status, extrict: false)
                    
                    MidleDetail
                    
                    AnalitycsView(popularity: $viewModel.serie.popularity, voteAvg: $viewModel.serie.voteAverage, voteCount: $viewModel.serie.voteCount)
                    
                }
                .padding()
                .frame(width: screen.width)
                .clipShape(RoundedRectangle(cornerRadius: 15))
            }
        }
        .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
        .edgesIgnoringSafeArea(.vertical)
    }
    
    // MARK: - Properties
    @State var viewModel: TVSerieModel
    @Binding var show: Bool
    @Binding var active: Bool
    @Binding var activeIndex: Int
    @Binding var isScrollable: Bool
    var bounds: GeometryProxy
    
    // MARK: - Actions
    
    // MARK: - Subviews
    var CloseButton: some View {
        VStack {
            HStack(alignment: .top) {
                Spacer()
                ZStack {
                    VStack {
                        Image(systemName: "xmark")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.white)
                    }
                    .frame(width: 36, height: 36)
                    .background(Color.black)
                    .clipShape(Circle())
                    .onTapGesture {
                        impact(style: .medium)
                        show = false
                        active = false
                        activeIndex = -1
                        isScrollable = false
                    }
                }
                .padding(30)
            }
            Spacer()
        }
        .frame(maxWidth: show ? .infinity : bounds.size.width - 60)
        .frame(width: screen.width, height: show ? screen.height * 0.4 : screen.width - 145)
        .background(
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
                .frame(width: screen.width - 145)
        )
        .clipShape(RoundedRectangle(cornerRadius: getCardCornerRadius(bounds: bounds), style: .continuous))
        .shadow(color: Color.black.opacity(0.3), radius: 20, x: 0, y: 20)
    }
    
    var MidleDetail: some View {
        VStack(alignment: .leading, spacing: 15) {
            if !detailViewModel.detail.serie.genres.isEmpty {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(detailViewModel.detail.serie.genres, id: \.self) { data in
                            GenreCard(name: data.name)
                        }
                    }
                    .padding(10)
                }
            }
            
            Text(viewModel.serie.overview)
                .font(.body)
                .foregroundColor(.black)
            
            HStack(spacing: 40) {
                Spacer()
                
                VStack {
                    Text("\(detailViewModel.detail.serie.numberOfEpisodes)")
                        .font(.title)
                        .bold()
                    
                    Text("ep_title".localized)
                        .font(.subheadline)
                }
                
                VStack {
                    Text("\(detailViewModel.detail.serie.seasons.count)")
                        .font(.title)
                        .bold()
                    
                    Text("season_title".localized)
                        .font(.subheadline)
                }
                
                Spacer()
            }
            
            if !detailViewModel.detail.serie.seasons.isEmpty {
                SeasonsView(season: $detailViewModel.detail.serie.seasons)
            }
            
            if !detailViewModel.detail.serie.networks.isEmpty {
                NetworksView(networks: $detailViewModel.detail.serie.networks)
            }
            
            if !detailViewModel.detail.serie.createdBy.isEmpty {
                CreatorsView(creators: $detailViewModel.detail.serie.createdBy)
            }
            
            if !detailViewModel.detail.serie.productionCountries.isEmpty {
                CountriesView(countries: $detailViewModel.detail.serie.productionCountries)
            }
        }
    }
}

struct TVSeriesView_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { bounds in
            TVSerieDetailsView(detailViewModel: TVSerieViewModel(), viewModel: TVSerieModel(serie: emptyTVSerie), show: .constant(true), active: .constant(true), activeIndex: .constant(-1), isScrollable: .constant(true), bounds: bounds)
        }
    }
}


