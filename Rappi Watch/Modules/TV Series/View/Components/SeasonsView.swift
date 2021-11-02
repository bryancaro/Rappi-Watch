//
//  SeasonsView.swift
//  Rappi Watch
//
//  Created by Bryan Caro on 10/29/21.
//

import SwiftUI

struct SeasonsView: View {
    @Binding var season: [Season]
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("season_title".localized)
                .font(.body)
                .bold()
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(season, id: \.self) { vm in
                        SeasonCard(image: vm.posterPath ?? "", title: vm.name ?? "", date: vm.airDate ?? "")
                    }
                }
                .padding(.vertical)
            }
        }
    }
}

struct SeasonsView_Previews: PreviewProvider {
    static var previews: some View {
        SeasonsView(season: .constant([Season]()))
    }
}
