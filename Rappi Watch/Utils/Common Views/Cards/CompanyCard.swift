//
//  CompanyCard.swift
//  Rappi Watch
//
//  Created by Bryan Caro on 10/28/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct CompanyCard: View {
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
                        .frame(width: 65, height: 65)
                }
                .transition(.fade(duration: 0.5))
                .aspectRatio(contentMode: .fit)
                .frame(width: 65, height: 65, alignment: .center)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 0)
            
            Text(name)
                .font(.caption)
                .fontWeight(.light)
        }
        .padding()
    }
}

struct CompanyCard_Previews: PreviewProvider {
    static var previews: some View {
        CompanyCard(image: "", name: "")
    }
}
