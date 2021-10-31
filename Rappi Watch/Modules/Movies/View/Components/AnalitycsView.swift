//
//  FooterDetailsView.swift
//  Rappi Watch
//
//  Created by Bryan Caro on 10/28/21.
//

import SwiftUI

struct AnalitycsView: View {
    @Binding var popularity: Double
    @Binding var voteAvg: Double
    @Binding var voteCount: Int
    var body: some View {
        VStack(alignment: .leading) {
            Text("Analytics")
                .font(.body)
                .bold()

            HStack(spacing: 30) {
                Spacer()

                RingView(textColor: .black, percent: CGFloat(popularity), title: "Popularity")

                RingView(textColor: .black, percent: CGFloat(voteCount), title: "People Voted")

                RingView(textColor: .black, percent: CGFloat(voteAvg), title: "Vote")

                Spacer()
            }
        }
    }
}

struct FooterDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        AnalitycsView(popularity: .constant(0), voteAvg: .constant(0), voteCount: .constant(0))
    }
}
