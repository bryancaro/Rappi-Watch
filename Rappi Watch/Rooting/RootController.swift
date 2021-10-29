//
//  RootController.swift
//  Rappi Watch
//
//  Created by Bryan Caro on 10/28/21.
//

import SwiftUI

struct RootController: View {
    @State var showLaunchScreenUI = true
    @State var showHomeView = false
    
    var body: some View {
        ZStack {
            HomeView(showHomeView: $showHomeView)
                .opacity(!showHomeView ? 0 : 1)
            
            LaunchScreenUI(showLaunchScreenUI: $showLaunchScreenUI)
                .opacity(showHomeView ? 0 : 1)
            
            GeometryReader { proxy in
                let size = proxy.size
                OnboardingView(screenSize: size, action: {
                    showHomeView = true
                })
            }
            .opacity(!showLaunchScreenUI ? 1 : 0)
            .opacity(showHomeView ? 0 : 1)
        }
        .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
    }
}

struct RootController_Previews: PreviewProvider {
    static var previews: some View {
        RootController()
    }
}
