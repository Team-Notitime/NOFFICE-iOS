//
//  SceneDelegate.swift
//  Noffice
//
//  Created by DOYEON LEE on 7/1/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = ViewController() // 초기 ViewController 설정
        window?.makeKeyAndVisible()
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
