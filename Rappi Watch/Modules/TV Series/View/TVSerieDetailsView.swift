//
//  TVSerieDetailsView.swift
//  Rappi Watch
//
//  Created by Bryan Caro on 10/29/21.
//

import SwiftUI

struct TVSerieDetailsView: View {
    @Binding var show: Bool
    @Binding var active: Bool
    @Binding var activeIndex: Int
    @Binding var isScrollable: Bool
    var bounds: GeometryProxy
    
    var body: some View {
        ScrollView {
            VStack {
                CloseButton
                
                VStack(spacing: 20) {
                    TopDetailsView(title: "The Joker", date: "2003-07-19", rating: 4.5, status: "Released", extrict: true)
                    
                    MidleDetail
                    
                    AnalitycsView()
                    
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
            Image("joker")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: screen.width - 145)
        )
        .clipShape(RoundedRectangle(cornerRadius: getCardCornerRadius(bounds: bounds), style: .continuous))
        .shadow(color: Color.black.opacity(0.3), radius: 20, x: 0, y: 20)
    }
    
    var MidleDetail: some View {
        VStack(alignment: .leading, spacing: 15) {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(0..<5) { data in
                        GenreCard(name: "Crime")
                    }
                }
                .padding(10)
            }
            
            Text("The Joker is a supervillain who appears in American comic books published by DC Comics. The Joker was created by Bill Finger, Bob Kane, and Jerry Robinson and first appeared in the debut issue of the comic book Batman on April 25, 1940.")
                .font(.body)
                .foregroundColor(.black)

            HStack(spacing: 40) {
                Spacer()

                VStack {
                    Text("45")
                        .font(.title)
                        .bold()

                    Text("Episodes")
                        .font(.subheadline)
                }

                VStack {
                    Text("45")
                        .font(.title)
                        .bold()

                    Text("Seasons")
                        .font(.subheadline)
                }

                Spacer()
            }
            
            SeasonsView()
            
            NetworksView()
            
            CreatorsView()
            
            CountriesView()
        }
    }
}

struct TVSeriesView_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { bounds in
            TVSerieDetailsView(show: .constant(true), active: .constant(true), activeIndex: .constant(-1), isScrollable: .constant(true), bounds: bounds)
        }
    }
}


