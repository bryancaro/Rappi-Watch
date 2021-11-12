//
//  Utils.swift
//  Rappi Watch
//
//  Created by Bryan Caro on 10/28/21.
//

import UIKit
import SwiftUI

let screen = UIScreen.main.bounds

func haptic(type: UINotificationFeedbackGenerator.FeedbackType) {
    UINotificationFeedbackGenerator().notificationOccurred(type)
}

func impact(style: UIImpactFeedbackGenerator.FeedbackStyle) {
    UIImpactFeedbackGenerator(style: style).impactOccurred()
}

func dismissLoadingView(completion: @escaping() -> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
        completion()
    }
}

func getCardWidth(bounds: GeometryProxy) -> CGFloat {
    if bounds.size.width > 712 {
        return 712
    }
    
    return bounds.size.width - 60
}

func getCardCornerRadius(bounds: GeometryProxy) -> CGFloat {
    if bounds.size.width < 712 && bounds.safeAreaInsets.top < 44 {
        return 0
    }
    
    return 30
}

func getCardCornerRadius2(bodyWidth: CGFloat, topInset: CGFloat) -> CGFloat {
    if bodyWidth < 712 && topInset < 44 {
        return 0
    }
    
    return 30
}

extension String {
    var length: Int {
        self.count
    }
    var localized: String {
        var localizedString = NSLocalizedString(self, comment: "")
        localizedString = localizedString.replacingOccurrences(of: "%s", with: "%@")
        localizedString = localizedString.replacingOccurrences(of: "%1$s", with: "%@")
        localizedString = localizedString.replacingOccurrences(of: "%2$s", with: "%@")
        localizedString = localizedString.replacingOccurrences(of: "%3$s", with: "%@")
        localizedString = localizedString.replacingOccurrences(of: "%4$s", with: "%@")
        return localizedString
    }
}

public extension View {
    
    /**
     Bind any `CGFloat` value within a `GeometryProxy` value
     to an external binding.
     */
    func bindGeometry(
        to binding: Binding<CGFloat>,
        reader: @escaping (GeometryProxy) -> CGFloat) -> some View {
        self.background(GeometryBinding(reader: reader))
            .onPreferenceChange(GeometryPreference.self) {
                binding.wrappedValue = $0
        }
    }
    
    func bindSafeAreaInset(
        of edge: Edge,
        to binding: Binding<CGFloat>) -> some View {
        self.bindGeometry(to: binding) {
            self.inset(for: $0, edge: edge)
        }
    }
}

private struct GeometryBinding: View {
    
    let reader: (GeometryProxy) -> CGFloat
    
    var body: some View {
        GeometryReader { geo in
            Color.clear.preference(
                key: GeometryPreference.self,
                value: self.reader(geo)
            )
        }
    }
}

private struct GeometryPreference: PreferenceKey {
    
    typealias Value = CGFloat

    static var defaultValue: CGFloat = 0

    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = max(value, nextValue())
    }
}

private extension View {
    
    func inset(for geo: GeometryProxy, edge: Edge) -> CGFloat {
        let insets = geo.safeAreaInsets
        switch edge {
        case .top: return insets.top
        case .bottom: return insets.bottom
        case .leading: return insets.leading
        case .trailing: return insets.trailing
        }
    }
}
