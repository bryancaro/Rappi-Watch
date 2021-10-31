//
//  OnboardingView.swift
//  Rappi Watch
//
//  Created by Bryan Caro on 10/28/21.
//

import SwiftUI

struct OnboardingView: View {
    @State var offset: CGFloat = 0
    var screenSize: CGSize
    
    var action: () -> Void
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                    .frame(height: 100)
                
                PageControl(offset: $offset) {
                    HStack(spacing:0) {
                        ForEach(intros) { intro in
                            VStack {
                                Text(intro.title)
                                    .font(.title)
                                    .bold()
                                    .multilineTextAlignment(.center)
                                    .padding(.top)
                                
                                Text(intro.description)
                                    .font(.body)
                                    .padding(.horizontal)
                                    .multilineTextAlignment(.center)
                                
                                Image(intro.image)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: screen.width - 50)
                                    .offset(y: 50)
                            }
                            .frame(width:screenSize.width)
                        }
                    }
                }
                .edgesIgnoringSafeArea(.bottom)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            
            VStack {
                Spacer()
                
                HStack(alignment:.bottom) {
                    HStack(spacing: 12) {
                        ForEach(intros.indices, id: \.self){ index in
                            Capsule()
                                .fill(Color("RappiColor"))
                                .frame(width: getIndex() == index ? 20 : 7, height: 7)
                        }
                    }
                    .overlay(
                        Capsule()
                            .fill(Color("RappiColor"))
                            .frame(width: 20, height: 7)
                            .offset(x: getIndicatorOffset())
                        ,alignment: .leading
                    )
                    .shadow(color: Color.black.opacity(0.4), radius: 10, x: 0, y: 0)
                    .padding()
                    .background(BlurView(style: .systemChromeMaterial))
                    .cornerRadius(20)
                    .offset(x: 10, y: -15)
                    
                    Spacer()
                    
                    Button {
                        impact(style: .heavy)
                        
                        if intros[getIndex()].id == intros.last?.id {
                            action()
                        } else {
                            let index = min(getIndex() + 1, intros.count - 1)
                            offset = CGFloat(index) * screenSize.width
                        }
                    } label:{
                        Image(systemName: "chevron.right")
                            .font(.title2.bold())
                            .foregroundColor(.white)
                            .padding(20)
                            .background(
                                Circle()
                                    .foregroundColor(Color("RappiColor"))
                            )
                            .shadow(color: Color.black.opacity(0.4), radius: 10, x: 4, y: 4)
                    }
                }
                .padding()
                .offset(y: -20)
            }
            .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0), value: getIndex())
        }
    }
    
    func getIndicatorOffset() -> CGFloat{
        let progress = offset / screenSize.width
        let maxWidth:CGFloat = 12 + 7
        return progress * maxWidth
    }
    
    
    func getIndex() -> Int{
        let progress = round(offset / screenSize.width)
        
        let index = min(Int(progress),intros.count - 1)
        return index
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView(screenSize: CGSize(width: 50, height: 50), action: {})
    }
}

struct Intro: Identifiable{
    var id = UUID().uuidString
    var image: String
    var title: String
    var description: String
}

var intros: [Intro] = [
    Intro(image: "screen_once", title: "Discover great new movies", description: "And never miss the ones one you want to watch"),
    Intro(image: "screen_two", title: "Discover great TV series", description: "And see which one is with the best score")
]
