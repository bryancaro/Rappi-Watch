//
//  GenreCard.swift
//  Rappi Watch
//
//  Created by Bryan Caro on 10/29/21.
//

import SwiftUI

struct GenreCard: View {
    var name: String
    
    var body: some View {
        Text(name)
            .font(.footnote)
            .foregroundColor(.white)
            .padding(7)
            .background(Color.black)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .shadow(color: Color.black.opacity(0.3), radius: 4, x: 2, y: 2)
    }
}

struct GenreCard_Previews: PreviewProvider {
    static var previews: some View {
        GenreCard(name: "Sci-Fi & Fantasy")
    }
}
