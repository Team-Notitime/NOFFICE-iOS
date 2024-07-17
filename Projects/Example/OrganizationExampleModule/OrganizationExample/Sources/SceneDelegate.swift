//
//  SceneDelegate.swift
//  Noffice
//
//  Created by DOYEON LEE on 7/1/24.
//

import UIKit

import OrganizationPresent
import Assets

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        let viewController = OrganizationTabViewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        window?.rootViewController = navigationController
        
        window?.backgroundColor = .fullWhite
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) { }

    func sceneDidBecomeActive(_ scene: UIScene) { }

    func sceneWillResignActive(_ scene: UIScene) { }

    func sceneWillEnterForeground(_ scene: UIScene) { }

    func sceneDidEnterBackground(_ scene: UIScene) { }
}
