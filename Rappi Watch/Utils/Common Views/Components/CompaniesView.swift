//
//  CompaniesView.swift
//  Rappi Watch
//
//  Created by Bryan Caro on 10/28/21.
//

import SwiftUI

struct CompaniesView: View {
    @Binding var companies: [ProductionCompany]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("prod_company_title".localized)
                .font(.body)
                .bold()

            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(companies, id: \.self) { vm in
                        CompanyCard(image: "\(ConfigReader.imgBaseUrl())\(vm.logoPath ?? "")", name: vm.name)
                    }
                }
            }
        }
    }
}

struct CompaniesView_Previews: PreviewProvider {
    static var previews: some View {
        CompaniesView(companies: .constant([ProductionCompany]()))
    }
}
