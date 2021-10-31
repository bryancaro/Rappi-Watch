//
//  LoadingView.swift
//  Rappi Watch
//
//  Created by Bryan Caro on 10/30/21.
//

import SwiftUI

struct LoadingView: View {
    @State var show = false
    var title: String
    var name: String
    
    var body: some View {
        VStack {
            Text(title)
                .font(.subheadline)
                .opacity(show ? 1 : 0)
                .animation(Animation.linear(duration: 1).delay(0.2))
            
            LottieView(filename: name)
                .frame(width: screen.width * 0.3, height: screen.width * 0.3)
                .opacity(show ? 1 : 0)
                .animation(Animation.linear(duration: 1).delay(0.4))
        }
        .padding()
        .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
        .onAppear {
            show = true
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView(title: "Loading", name: "not_found")
    }
}
