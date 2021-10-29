//
//  CreatorCard.swift
//  Rappi Watch
//
//  Created by Bryan Caro on 10/29/21.
//

import SwiftUI

struct CreatorCard: View {
    var body: some View {
        VStack(spacing: 5) {
            Image("joker")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 50, height: 50, alignment: .center)
                .clipShape(Circle())
                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 4, y: 4)
            
            Text("Joker")
                .font(.footnote)
        }
    }
}

struct CreatorCard_Previews: PreviewProvider {
    static var previews: some View {
        CreatorCard()
    }
}
