//
//  CreatorsView.swift
//  Rappi Watch
//
//  Created by Bryan Caro on 10/29/21.
//

import SwiftUI

struct CreatorsView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("Creators")
                .font(.body)
                .bold()
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 30) {
                    ForEach(1..<4) { _ in
                        CreatorCard()
                    }
                }
                .padding(.vertical)
            }
        }
    }
}

struct CreatorsView_Previews: PreviewProvider {
    static var previews: some View {
        CreatorsView()
    }
}
