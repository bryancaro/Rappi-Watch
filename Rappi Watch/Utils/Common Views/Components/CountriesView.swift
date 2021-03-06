//
//  CountriesView.swift
//  Rappi Watch
//
//  Created by Bryan Caro on 10/29/21.
//

import SwiftUI

struct CountriesView: View {
    @Binding var countries: [ProductionCountry]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("prod_country_title".localized)
                .font(.body)
                .bold()

            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(countries, id: \.self) { vm in
                        CountryCard(image: vm.iso3166_1, name: vm.name)
                    }
                }
            }
        }
    }
}

struct CountriesView_Previews: PreviewProvider {
    static var previews: some View {
        CountriesView(countries: .constant([ProductionCountry]()))
    }
}
