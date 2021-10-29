//
//  BarChartView.swift
//  Rappi Watch
//
//  Created by Bryan Caro on 10/28/21.
//

import SwiftUI

struct BarChartView: View {
    @State var number: Double = 0
    var title: String
    var data: Double
    
    var body: some View {
        VStack {
            Text(title)
                .font(.body)
                .bold()
                .frame(width: screen.width - 20, alignment: .leading)

            ZStack(alignment: .leading) {
                Capsule()
                    .foregroundColor(.white)
                    .frame(width: (screen.width - 20), height: 20)

                Capsule()
                    .frame(width: (number/3000000), height: 20)
                    .foregroundColor(.red)
            }
            .frame(width: screen.width - 20, alignment: .leading)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 0)

            HStack {
                Spacer()
                Text("\(number, specifier: "%.2f")$")
                    .font(.footnote)
            }
        }
        .animation(.spring(), value: number)
        .onAppear(perform: onAppear)
    }
    
    // MARK: - Actions
    func onAppear() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            number = data
        }
    }
}

struct BarChartView_Previews: PreviewProvider {
    static var previews: some View {
        BarChartView(title: "Budge", data: 450000)
    }
}
