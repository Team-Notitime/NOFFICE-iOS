//
//  DebugButtonConfig.swift
//  Noffice
//
//  Created by DOYEON LEE on 8/18/24.
//

import Foundation
import UIKit
import SwiftUI

import Router

@MainActor
final class DebugButtonConfig {
    static func setup(window: UIWindow?) {
#if DEV
        setupDebugButton(window: window)
#endif
    }
    
    private static func setupDebugButton(window: UIWindow?) {
        guard let window = window else { return }
        
        let debugButtonView = UIView()
        debugButtonView.backgroundColor = .clear
        debugButtonView.isUserInteractionEnabled = true
        debugButtonView.translatesAutoresizingMaskIntoConstraints = false
        
        window.addSubview(debugButtonView)
        
        // Create the button
        let button = UIButton(type: .system)
        button.setTitle("🐱", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        button.layer.cornerRadius = 25
        button.addTarget(self, action: #selector(debugButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        debugButtonView.addSubview(button)
        
        // Set constraints for the button
        NSLayoutConstraint.activate([
            button.widthAnchor.constraint(equalToConstant: 50),
            button.heightAnchor.constraint(equalToConstant: 50),
            button.trailingAnchor.constraint(equalTo: debugButtonView.trailingAnchor, constant: -20),
            button.bottomAnchor.constraint(equalTo: debugButtonView.bottomAnchor, constant: -20)
        ])
        
        // Set constraints for the debug button view
        NSLayoutConstraint.activate([
            debugButtonView.trailingAnchor.constraint(equalTo: window.trailingAnchor),
            debugButtonView.bottomAnchor.constraint(equalTo: window.bottomAnchor),
            debugButtonView.widthAnchor.constraint(equalToConstant: 80),
            debugButtonView.heightAnchor.constraint(equalToConstant: 80)
        ])
        
        window.bringSubviewToFront(debugButtonView)
    }
    
    @objc private static func debugButtonTapped() {
        let debugVC = UIHostingController(rootView: DebugView())
        Router.shared.push(debugVC)
    }
}
