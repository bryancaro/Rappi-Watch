//
//  SideButtonsView.swift
//  Rappi Watch
//
//  Created by Bryan Caro on 10/28/21.
//

import SwiftUI

struct SideButtonsView: View {
    @Binding var switchCard: Bool
    
    var body: some View {
        VStack {
            Text("Movies")
                .font(.footnote)
                .bold()
            
            CustomButton(active: .constant(true), image: "film.fill", action: {switchCard.toggle()})
            
            CustomButton(active: .constant(false), image: "play.tv.fill", action: {switchCard.toggle()})
            
            Text("Category")
                .font(.footnote)
                .bold()
                .padding(.top)
            
            CustomButton(active: .constant(true), image: "heart.fill", action: {})
            
            CustomButton(active: .constant(false), image: "flame.fill", action: {})
            
            CustomButton(active: .constant(false), image: "calendar.badge.clock", action: {})
            
        }
        .frame(maxWidth: 100)
    }
}

struct SideButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        SideButtonsView(switchCard: .constant(false))
    }
}
