//
//  LoadMoreButton.swift
//  Rappi Watch
//
//  Created by Bryan Caro on 10/31/21.
//

import SwiftUI

struct LoadMoreButton: View {
    @Binding var active: Bool
    var action: () -> Void
    
    var body: some View {
        Button(action: buttonTapped) {
            Text(title)
                .font(.footnote)
                .foregroundColor(.white)
                .padding(10)
                .background(background)
                .cornerRadius(15)
                .shadow(color: Color.black.opacity(0.3), radius: 10, x: 4, y: 4)
        }
        .buttonStyle(.plain)
    }
    // MARK: - Properties
    var background: Color {
        return active ? Color.black : Color.red
    }
    
    var title: String {
        return active ? "Load more" : "Empty"
    }
    
    // MARK: - Actions
    func buttonTapped() {
        impact(style: .soft)
        action()
    }
}

struct LoadMoreButton_Previews: PreviewProvider {
    static var previews: some View {
        LoadMoreButton(active: .constant(false), action: {})
    }
}
