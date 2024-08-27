//
//  NotificationCenterSetting.swift
//  Noffice
//
//  Created by DOYEON LEE on 8/28/24.
//

import Foundation
import NotificationCenterUtility
import Router

@MainActor
struct NotificationCenterSetting {
    static func setup() {
        let notificationCenterManager = NotificationCenterManager<Void>(
            name: .tokenExpired
        )
        
        notificationCenterManager.observe { _ in
            Router.shared.presentFullScreen(.signup)
        }
    }
}
