//
//  KnownForView.swift
//  Rappi Watch
//
//  Created by Bryan Caro on 11/12/21.
//

import SwiftUI

struct KnownForView: View {
    @Binding var data: [KnownFor]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("know_title".localized)
                .font(.body)
                .bold()

            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(data, id: \.self) { vm in
                        KnowForCard(image: "\(ConfigReader.imgBaseUrl())\(vm.posterPath ?? "")", name: vm.originalTitle ?? "")
                    }
                }
            }
        }
    }
}

struct KnownForView_Previews: PreviewProvider {
    static var previews: some View {
        KnownForView(data: .constant([KnownFor]()))
    }
}
