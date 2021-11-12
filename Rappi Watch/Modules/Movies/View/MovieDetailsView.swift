//
//  MovieDetailsView.swift
//  Rappi Watch
//
//  Created by Bryan Caro on 10/28/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct MovieDetailsView: View {
    @ObservedObject var detailViewModel: MovieViewModel
    
    var body: some View {
        ScrollView {
            VStack {
                CloseButton
                
                VStack(spacing: 20) {
                    TopDetailsView(title: viewModel.movie.title, date: viewModel.movie.releaseDate, rating: viewModel.movie.voteAverage, status: detailViewModel.detail.movie.status, extrict: viewModel.movie.adult)
                    
                    MidleDetail
                    
                    AnalitycsView(popularity: $viewModel.movie.popularity, voteAvg: $viewModel.movie.voteAverage, voteCount: $viewModel.movie.voteCount)
                    
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
    @State var viewModel: MovieModel
    @Binding var show: Bool
    @Binding var active: Bool
    @Binding var activeIndex: Int
    @Binding var isScrollable: Bool
    var bodyWidth: CGFloat
    var topInset: CGFloat
    
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
        .frame(maxWidth: show ? .infinity : bodyWidth - 60)
        .frame(width: screen.width, height: show ? screen.height * 0.4 : screen.width - 145)
        .background(
            WebImage(url: URL(string: "\(ConfigReader.imgBaseUrl())\(viewModel.movie.posterPath ?? "")"))
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
        .clipShape(RoundedRectangle(cornerRadius: getCardCornerRadius2(bodyWidth: bodyWidth, topInset: topInset), style: .continuous))
        .shadow(color: Color.black.opacity(0.3), radius: 20, x: 0, y: 20)
    }
    
    var MidleDetail: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text(viewModel.movie.overview)
                .font(.body)
                .foregroundColor(.black)
            
            BarChartView(title: "Budge", data: $detailViewModel.detail.movie.budget)
            
            BarChartView(title: "Revenue", data: $detailViewModel.detail.movie.revenue)
            
            CompaniesView(companies: $detailViewModel.detail.movie.productionCompanies)
            
            CountriesView(countries: $detailViewModel.detail.movie.productionCountries)
        }
    }
}

//struct MovieDetailsView_Previews: PreviewProvider {
//    static var previews: some View {
//        GeometryReader { bounds in
//            MovieDetailsView(detailViewModel: MovieViewModel(), viewModel: MovieModel(movie: emptyMovie), show: .constant(true), active: .constant(true), activeIndex: .constant(-1), isScrollable: .constant(true), bounds: bounds)
//        }
//    }
//}
