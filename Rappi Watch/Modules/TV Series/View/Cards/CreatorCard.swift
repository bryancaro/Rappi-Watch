//
//  CreatorCard.swift
//  Rappi Watch
//
//  Created by Bryan Caro on 10/29/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct CreatorCard: View {
    var image: String
    var name: String
    
    var body: some View {
        VStack(spacing: 5) {
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
                .frame(width: 50, height: 50, alignment: .center)
                .clipShape(Circle())
                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 4, y: 4)
            
            Text(name)
                .font(.footnote)
        }
    }
}

struct CreatorCard_Previews: PreviewProvider {
    static var previews: some View {
        CreatorCard(image: "", name: "")
    }
}
