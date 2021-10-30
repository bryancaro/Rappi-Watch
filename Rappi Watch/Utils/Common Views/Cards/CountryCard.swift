//
//  CountryCard.swift
//  Rappi Watch
//
//  Created by Bryan Caro on 10/30/21.
//

import SwiftUI

struct CountryCard: View {
    var image: String
    var name: String
    
    var body: some View {
        VStack {
            Image(image.lowercased())
                .resizable()
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

struct CountryCard_Previews: PreviewProvider {
    static var previews: some View {
        CountryCard(image: "", name: "")
    }
}
