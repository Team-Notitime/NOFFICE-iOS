//
//  NotificationManager.swift
//  NotificationCenterUtility
//
//  Created by DOYEON LEE on 8/27/24.
//

import Foundation

public final class NotificationCenterManager<T> {
    
    private let name: Notification.Name
    
    /// Initializes the NotificationCenterManager with a specific notification name.
    ///
    /// - Parameter notificationName: The name used to identify the notification.
    public init(name: Notification.Name) {
        self.name = name
    }
    
    /// Registers an observer for the notification and executes the provided callback when the notification is received.
    ///
    /// - Parameter callback: The callback to be executed when the notification is received.
    public func observe(callback: @escaping (T?) -> Void) {
        NotificationCenter.default.addObserver(
            forName: name,
            object: nil,
            queue: .main
        ) { notification in
            let userInfo = notification.userInfo?["data"] as? T
            callback(userInfo)
        }
    }
    
    /// Posts the notification with the associated data.
    ///
    /// - Parameter data: The data of type `T` to be passed with the notification.
    public func post(data: T?) {
        NotificationCenter.default.post(
            name: name,
            object: nil,
            userInfo: ["data": data as Any]
        )
    }
    
    /// Removes the observer for the notification.
    public func removeObserver() {
        NotificationCenter.default.removeObserver(
            self,
            name: name,
            object: nil
        )
    }
    
    deinit {
        removeObserver()
    }
}
