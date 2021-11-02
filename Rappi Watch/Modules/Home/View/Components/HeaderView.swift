//
//  HeaderView.swift
//  Rappi Watch
//
//  Created by Bryan Caro on 10/28/21.
//

import SwiftUI

struct HeaderView: View {
    @Environment(\.colorScheme) var colorScheme
    
    @Binding var searchText: String
    @Binding var text: String
    
    var onEditingChanged: (Bool) -> Void
    var onCommit: () -> Void
    
    var body: some View {
        HStack {
            Image("logo_rappi")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 60, height: 60)
                .padding(10)
            
            Spacer()
            
            SearchBar
        }
    }
    
    // MARK: - Subviews
    var SearchBar: some View {
        ZStack {
            HStack {
                Image(systemName: "magnifyingglass")
                    .font(.system(size: 20))
                
                TextField(text, text: $searchText, onEditingChanged: onEditingChanged, onCommit: onCommit)
                    .font(.system(size: 15))
                    .accessibilityIdentifier("SearchFilter")
            }
            .foregroundColor(.gray)
            .padding(.leading, 13)
        }
        .frame(width: screen.width * 0.75, height: 60)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0.0, y: 0.0)
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView(searchText: .constant(""), text: .constant("What movie are you looking for?"), onEditingChanged: { data in }, onCommit: { })
    }
}
