//
//  RatingStartView.swift
//  Rappi Watch
//
//  Created by Bryan Caro on 10/28/21.
//

import SwiftUI

struct RatingStartView: View {
    @Environment(\.colorScheme) var colorScheme
    
    @Binding var rating: Double
    
    var maximumRating = 5
    
    var offImage: Image?
    var onImage = Image(systemName: "star.fill")
    
    var offColor = Color.black.opacity(0.1)
    var onColor = Color.yellow
    
    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            Text("\(rating, specifier: "%.1f")")
                .font(.body)
                .bold()
                .padding(.trailing, 5)
                .offset(y: 2)

            ForEach(1..<maximumRating + 1) { number in
                image(for: number)
                    .font(.system(size: 17))
                    .foregroundColor(number > Int(rating) ? colorScheme == .light ? offColor : .gray : onColor)
                    .shadow(color: shadowColor, radius: 15, x: 4, y: 4)
            }
        }
    }
    
    // MARK: - Properties
    var shadowColor: Color {
        return colorScheme == .light ? Color.black.opacity(0.2) : Color.white.opacity(0.2)
    }
    func image(for number: Int) -> Image {
        if number > Int(rating) {
            return offImage ?? onImage
        } else {
            return onImage
        }
    }
}

struct RatingStartView_Previews: PreviewProvider {
    static var previews: some View {
        RatingStartView(rating: .constant(2))
    }
}
