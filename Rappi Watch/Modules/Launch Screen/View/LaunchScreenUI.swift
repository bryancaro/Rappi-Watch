//
//  LaunchScreenUI.swift
//  Rappi Watch
//
//  Created by Bryan Caro on 10/28/21.
//

import SwiftUI

struct LaunchScreenUI: View {
    @Binding var showLaunchScreenUI: Bool
    
    var body: some View {
        ZStack {
            VStack {
                Image("logo_rappiwatch")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: showLaunchScreenUI ? 300 : 100, height: showLaunchScreenUI ? 125: 100)
                
                if !showLaunchScreenUI {
                    Spacer()
                }
            }
        }
        .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                showLaunchScreenUI = false
            }
        }
    }
}

struct LaunchScreenUI_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreenUI(showLaunchScreenUI: .constant(true))
    }
}
