//
//  CountriesView.swift
//  Rappi Watch
//
//  Created by Bryan Caro on 10/29/21.
//

import SwiftUI

struct CountriesView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("Production Countries")
                .font(.body)
                .bold()

            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(1..<4) { _ in
                        CompanyCard()
                    }
                }
            }
        }
    }
}

struct CountriesView_Previews: PreviewProvider {
    static var previews: some View {
        CountriesView()
    }
}
