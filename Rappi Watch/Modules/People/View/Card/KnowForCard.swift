//
//  KnowForCard.swift
//  Rappi Watch
//
//  Created by Bryan Caro on 11/12/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct KnowForCard: View {
    var image: String
    var name: String
    
    var body: some View {
        VStack {
            WebImage(url: URL(string: image))
                .resizable()
                .placeholder {
                    Image("logo_rappi")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 150, height: 200)
                }
                .transition(.fade(duration: 0.5))
                .aspectRatio(contentMode: .fill)
                .frame(width: 150, height: 200, alignment: .center)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 0)
            
            Text(name)
                .font(.title3)
                .fontWeight(.bold)
        }
        .padding()
    }
}

struct KnowForCard_Previews: PreviewProvider {
    static var previews: some View {
        KnowForCard(image: "", name: "hoemofemoefef")
    }
}
