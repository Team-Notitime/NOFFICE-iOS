//
//  SceneDelegate.swift
//  Noffice
//
//  Created by DOYEON LEE on 7/1/24.
//

import UIKit
import SwiftUI

import Assets
import KeychainUtility
import Router
import NotificationCenterUtility

import ProgressHUD

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        // Set root view
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = Router.shared
        
        let tabBarController = TabBarController()
        Router.shared.push(tabBarController)
        
        let tokenKeychainManager = KeychainManager<Token>()
        if let token = tokenKeychainManager.get() {
            print(token)
        } else {
            print("has no token")
            Router.shared.presentFullScreen(.signup, animated: false)
        }
        
        window?.makeKeyAndVisible()
        
        // Set setting
        NotificationCenterSetting.setup()
        
        // Set config
        DebugButtonConfig.setup(window: window)
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // 씬이 해제될 때 호출되는 메서드
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // 씬이 활성화될 때 호출되는 메서드
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // 씬이 비활성화될 때 호출되는 메서드
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // 씬이 포그라운드로 들어올 때 호출되는 메서드
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // 씬이 백그라운드로 들어갈 때 호출되는 메서드
    }
}
