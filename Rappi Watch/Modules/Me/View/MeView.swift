//
//  MeView.swift
//  Rappi Watch
//
//  Created by Bryan Caro on 10/28/21.
//

import SwiftUI

struct MeView: View {
    var action: () -> Void
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.white
                .edgesIgnoringSafeArea(.all)
            
            CoverView()
            
            VStack(spacing: 20) {
                Text("me_title".localized)
                    .font(.title2)
                    .bold()
                    .multilineTextAlignment(.center)
                
                Text("""
                         - Swift UI
                         - MVVM Arquitecture
                         - Data Provided by themoviedb
                         - Xcode 13.0
                         - Swift 5.5
                         """)
                    .font(.body)
                    .multilineTextAlignment(.leading)
                
                Button(action: action) {
                    Text("skip_title".localized)
                        .font(.title2)
                        .bold()
                        .foregroundColor(.white)
                        .frame(width: screen.width - 100, height: 45, alignment: .center)
                        .background(Color.black)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .shadow(color: Color.black.opacity(0.4), radius: 15, x: 0, y: 10)
                }
                .buttonStyle(.plain)
                .accessibilityIdentifier("skipMeButton")
            }
            .padding(.horizontal)
            .offset(y: 440)
        }
    }
}

struct MeViewPreviews: PreviewProvider {
    static var previews: some View {
        MeView(action: {})
    }
}

struct CoverView: View {
    @State var show = false
    @State var viewState = CGSize.zero
    @State var isDragging = false
    
    var body: some View {
        VStack {
            GeometryReader { geometry in
                VStack(spacing: 5) {
                    Image("me")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 70, height: 70, alignment: .center)
                        .clipShape(Circle())
                    
                    Text("me_name".localized)
                        .font(.system(size: geometry.size.width/15, weight: .bold))
                        .foregroundColor(.black)
                        .padding(10)
                }
                .padding(5)
                .background(BlurView(style: .systemUltraThinMaterialLight))
                .cornerRadius(20)
                .frame(width: screen.width, alignment: .center)
            }
            .offset(x: viewState.width/15, y: viewState.height/15)
            
            Spacer()
        }
        .multilineTextAlignment(.center)
        .padding(.top)
        .frame(height: 400)
        .frame(maxWidth: .infinity)
        .background(
            ZStack {
                Image("blub_red")
                    .offset(x: -150, y: 100)
                    .rotationEffect(Angle(degrees: show ? 360+90 : 90))
                    .blendMode(.plusDarker)
                    .animation(Animation.linear(duration: 100).repeatForever(autoreverses: false))
                    .onAppear { self.show = true }
                
                Image("blub_black")
                    .offset(x: -120, y: 200)
                    .rotationEffect(Angle(degrees: show ? 360 : 0), anchor: .leading)
                    .blendMode(.plusDarker)
                    .animation(Animation.linear(duration: 100).repeatForever(autoreverses: false))
                
                Image("blub_red")
                    .offset(x: -250, y: -200)
                    .rotationEffect(Angle(degrees: show ? 360+90 : 90))
                    .blendMode(.plusDarker)
                    .animation(Animation.linear(duration: 100).repeatForever(autoreverses: false))
                    .onAppear { self.show = true }
            }
        )
        .background(
            Image("logo_rappiwatch")
                .padding(.top, 100)
                .offset(x: viewState.width/25, y: viewState.height/25)
            , alignment: .center
        )
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
        .shadow(color: Color.black.opacity(0.3), radius: 10, x: 0, y: 30)
        .scaleEffect(isDragging ? 0.9 : 1)
        .animation(.timingCurve(0.2, 0.8, 0.2, 1, duration: 0.8))
        .rotation3DEffect(Angle(degrees: 5), axis: (x: viewState.width, y: viewState.height, z: 0))
        .gesture(
            DragGesture().onChanged { value in
                viewState = value.translation
                isDragging = true
            }
                .onEnded { value in
                    viewState = .zero
                    isDragging = false
                }
        )
    }
}
