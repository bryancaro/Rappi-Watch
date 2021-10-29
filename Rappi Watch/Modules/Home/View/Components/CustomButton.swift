//
//  CustomButton.swift
//  Rappi Watch
//
//  Created by Bryan Caro on 10/28/21.
//

import SwiftUI

struct CustomButton: View {
    @Binding var active: Bool
    var image: String
    var action: () -> Void
    
    var body: some View {
        Button(action: action, label: {
            Image(systemName: image)
                .font(.system(size: 20, weight: .bold, design: .default))
                .frame(width: 45, height: 45, alignment: .center)
                .foregroundColor(foregroundColor)
                .background(Color.white)
                .cornerRadius(10)
                .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 0)
                .padding(.vertical, 5)
        })
            .buttonStyle(.plain)
    }
    
    // MARK: - Properties
    var foregroundColor: Color {
        return active ? .red : .black
    }
}

struct CustomButton_Previews: PreviewProvider {
    static var previews: some View {
        CustomButton(active: .constant(false), image: "", action: {})
    }
}
