//
//  TopDetailsView.swift
//  Rappi Watch
//
//  Created by Bryan Caro on 10/28/21.
//

import SwiftUI

struct TopDetailsView: View {
    var title: String
    var date: String
    var rating: Double
    var status: String
    var extrict: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack {
                VStack(alignment: .leading) {
                    Text(title)
                        .font(.title)
                        .bold()

                    Text(date)
                        .font(.body)
                        .foregroundColor(.gray)
                }

                Spacer()

                if extrict {
                    Image("18")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 40, height: 40, alignment: .center)
                        .transition(.move(edge: .trailing))
                }
            }

            RatingStartView(rating: .constant(rating))

            Text(status)
                .font(.body)
                .foregroundColor(.gray)
                .bold()
        }
    }
}

struct TopDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        TopDetailsView(title: "The Joker", date: "2003-07-19", rating: 4.5, status: "Released", extrict: true)
    }
}
