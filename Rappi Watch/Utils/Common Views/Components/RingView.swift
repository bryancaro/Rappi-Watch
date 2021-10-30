//
//  RingView.swift
//  Rappi Watch
//
//  Created by Bryan Caro on 10/28/21.
//

import SwiftUI

struct RingView: View {
    var textColor: Color = .black
    var width: CGFloat = 70
    var height: CGFloat = 70
    var percent: CGFloat = 88
    var title: String = "Titulo"
    
    var body: some View {
        VStack {
            Ring

            Text(title)
                .font(.footnote)
        }
    }
    
    var Ring: some View {
        let multiplier = width / 44
        let progress = 1 - (percent / 100)

        return ZStack {
            Circle()
                .stroke(Color.black.opacity(0.1), style: StrokeStyle(lineWidth: 7 * multiplier))
                .frame(width: width, height: height)

            Circle()
                .trim(from: progress, to: 1)
                .stroke(
                    LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)), Color(#colorLiteral(red: 1, green: 0, blue: 0, alpha: 1))]), startPoint: .topTrailing, endPoint: .bottomLeading),
                    style: StrokeStyle(lineWidth: 7 * multiplier, lineCap: .round, lineJoin: .round, miterLimit: .infinity, dash: [20, 0], dashPhase: 0)
                )
                .rotationEffect(Angle(degrees: 90))
                .rotation3DEffect(Angle(degrees: 180), axis: (x: 1, y: 0, z: 0))
                .frame(width: width, height: height)
                .shadow(color:  Color(#colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)).opacity(0.4), radius: 3 * multiplier, x: 0, y: 0 * multiplier)

            Text("\(Int(percent))%")
                .font(.system(size: 8 * multiplier))
                .fontWeight(.bold)
                .foregroundColor(textColor)
        }
    }
}

struct RingView_Previews: PreviewProvider {
    static var previews: some View {
        RingView()
    }
}
