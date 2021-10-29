//
//  CompaniesView.swift
//  Rappi Watch
//
//  Created by Bryan Caro on 10/28/21.
//

import SwiftUI

struct CompaniesView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("Production Companies")
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

struct CompaniesView_Previews: PreviewProvider {
    static var previews: some View {
        CompaniesView()
    }
}