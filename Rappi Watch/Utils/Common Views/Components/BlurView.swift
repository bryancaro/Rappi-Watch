//
//  BlurView.swift
//  Rappi Watch
//
//  Created by Bryan Caro on 10/28/21.
//

import SwiftUI

struct BlurView: UIViewRepresentable {
    typealias UIViewType = UIView
    var style: UIBlurEffect.Style
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: CGRect.zero)
        view.backgroundColor = .clear
        
        let bluerEffect = UIBlurEffect(style: style)
        let bluerView = UIVisualEffectView(effect: bluerEffect)
        bluerView.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(bluerView, at: 0)
        
        NSLayoutConstraint.activate([
            bluerView.widthAnchor.constraint(equalTo: view.widthAnchor),
            bluerView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        
    }
}
