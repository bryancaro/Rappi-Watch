//
//  NetworksView.swift
//  Rappi Watch
//
//  Created by Bryan Caro on 10/29/21.
//

import SwiftUI

struct NetworksView: View {
    @Binding var networks: [Network]
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("network_title".localized)
                .font(.body)
                .bold()

            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(networks, id: \.self) { vm in
                        CompanyCard(image: "\(ConfigReader.imgBaseUrl())\(vm.logoPath ?? "")", name: vm.name)
                    }
                }
            }
        }
    }
}

struct NetworksView_Previews: PreviewProvider {
    static var previews: some View {
        NetworksView(networks: .constant([Network]()))
    }
}
