//
//  CustomButton.swift
//  Rappi Watch
//
//  Created by Bryan Caro on 10/28/21.
//

import SwiftUI

struct CustomButtonCategory: View {
    @Binding var selected: [CategoriesModel]
    var id: String
    var image: String
    var action: () -> Void
    
    var body: some View {
        Button(action: buttonTapped, label: {
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
        return selected.contains(where: { $0.id == id}) ? .red : .black
    }
    
    // MARK: - Action
    func buttonTapped() {
        impact(style: .medium)
        action()
    }
}

struct CustomButtonCategory_Previews: PreviewProvider {
    static var previews: some View {
        CustomButtonCategory(selected: .constant([CategoriesModel]()), id: "", image: "", action: {})
    }
}

struct CustomButtonFilter: View {
    @Binding var selected: [FilterModel]
    var id: String
    var image: String
    var action: () -> Void
    
    var body: some View {
        Button(action: buttonTapped, label: {
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
        return selected.contains(where: { $0.filter.image == image }) ? .red : .black
    }
    
    // MARK: - Action
    func buttonTapped() {
        impact(style: .medium)
        action()
    }
}
