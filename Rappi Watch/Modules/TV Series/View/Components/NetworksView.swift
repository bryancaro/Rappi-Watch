//
//  NetworksView.swift
//  Rappi Watch
//
//  Created by Bryan Caro on 10/29/21.
//

import SwiftUI

struct NetworksView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("Networks")
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

struct NetworksView_Previews: PreviewProvider {
    static var previews: some View {
        NetworksView()
    }
}
