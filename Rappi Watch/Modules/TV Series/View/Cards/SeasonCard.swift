//
//  SeasonCard.swift
//  Rappi Watch
//
//  Created by Bryan Caro on 10/29/21.
//

import SwiftUI

struct SeasonCard: View {
    var body: some View {
        ZStack(alignment: .bottom) {
            Image("joker")
                .resizable()
                .aspectRatio(contentMode: .fill)
            
            LinearGradient(gradient: Gradient(colors: [Color.black.opacity(0), .black]), startPoint: .top, endPoint: .bottom)
                .frame(height: 80/1.5, alignment: .center)
            
                VStack {
                    Text("Season 1")
                        .font(.body)
                    
                    Text("2015-07-10")
                        .font(.caption2)
                        .fontWeight(.thin)
                        .foregroundColor(.gray)
                }
                .foregroundColor(.white)
                .padding(2)
        }
        .frame(width: screen.width * 0.35, height: 80)
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .shadow(color: Color.black.opacity(0.5), radius: 5, x: 2, y: 2)
        .padding(5)
    }
}

struct SeasonCard_Previews: PreviewProvider {
    static var previews: some View {
        SeasonCard()
    }
}
