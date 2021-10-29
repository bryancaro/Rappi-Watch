//
//  FooterDetailsView.swift
//  Rappi Watch
//
//  Created by Bryan Caro on 10/28/21.
//

import SwiftUI

struct AnalitycsView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Analytics")
                .font(.body)
                .bold()

            HStack(spacing: 30) {
                Spacer()

                RingView(textColor: .black)

                RingView(textColor: .black)

                RingView(textColor: .black)

                Spacer()
            }
        }
    }
}

struct FooterDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        AnalitycsView()
    }
}
