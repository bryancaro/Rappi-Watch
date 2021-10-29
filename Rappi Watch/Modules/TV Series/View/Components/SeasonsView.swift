//
//  SeasonsView.swift
//  Rappi Watch
//
//  Created by Bryan Caro on 10/29/21.
//

import SwiftUI

struct SeasonsView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("Seasons")
                .font(.body)
                .bold()
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(1..<4) { _ in
                        SeasonCard()
                    }
                }
                .padding(.vertical)
            }
        }
    }
}

struct SeasonsView_Previews: PreviewProvider {
    static var previews: some View {
        SeasonsView()
    }
}