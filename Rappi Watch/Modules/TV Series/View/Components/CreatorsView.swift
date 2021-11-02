//
//  CreatorsView.swift
//  Rappi Watch
//
//  Created by Bryan Caro on 10/29/21.
//

import SwiftUI

struct CreatorsView: View {
    @Binding var creators: [CreatedBy]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("creator_title".localized)
                .font(.body)
                .bold()
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 30) {
                    ForEach(creators, id: \.self) { vm in
                        CreatorCard(image: vm.profilePath ?? "", name: vm.name)
                    }
                }
                .padding(.vertical)
            }
        }
    }
}

struct CreatorsView_Previews: PreviewProvider {
    static var previews: some View {
        CreatorsView(creators: .constant([CreatedBy]()))
    }
}
