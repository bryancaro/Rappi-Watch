//
//  CompanyCard.swift
//  Rappi Watch
//
//  Created by Bryan Caro on 10/28/21.
//

import SwiftUI

struct CompanyCard: View {
    var body: some View {
        VStack {
            Image("logo_rappi")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 65, height: 65, alignment: .center)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 0)
            
            Text("DreamWork")
                .font(.caption)
                .fontWeight(.light)
        }
        .padding()
    }
}

struct CompanyCard_Previews: PreviewProvider {
    static var previews: some View {
        CompanyCard()
    }
}
