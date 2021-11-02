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
