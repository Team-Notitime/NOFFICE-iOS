//
//  PulseConfig.swift
//  Noffice
//
//  Created by DOYEON LEE on 8/17/24.
//

import SwiftUI
import UIKit

import Pulse
import PulseUI

struct PulseConfig {
    public static func setup() {
        URLSessionProxyDelegate.enableAutomaticRegistration()
    }
    
    public static func getConsoleView() -> UIViewController {
        let view = NavigationView {
            ConsoleView()
        }
        return UIHostingController(rootView: view)
    }
}
