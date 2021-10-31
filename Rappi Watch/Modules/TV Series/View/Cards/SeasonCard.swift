//
//  SeasonCard.swift
//  Rappi Watch
//
//  Created by Bryan Caro on 10/29/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct SeasonCard: View {
    var image: String
    var title: String
    var date: String
    
    var body: some View {
        ZStack(alignment: .bottom) {
            WebImage(url: URL(string: "\(ConfigReader.imgBaseUrl())\(image)"))
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
                .frame(width: screen.width * 0.35, height: 80)
            
            LinearGradient(gradient: Gradient(colors: [Color.black.opacity(0), .black]), startPoint: .top, endPoint: .bottom)
                .frame(height: 80/1.5, alignment: .center)
            
                VStack {
                    Text(title)
                        .font(.body)
                    
                    Text(date)
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
        SeasonCard(image: "", title: "", date: "")
    }
}
