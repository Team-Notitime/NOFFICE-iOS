//
//  Router+Presentable.swift
//  Router
//
//  Created by DOYEON LEE on 8/1/24.
//

import UIKit

public extension Router {
    /// Pushes a view from right to left
    func push(
        _ presentable: Presentable,
        animated: Bool = true
    ) {
        let destination = resolvePresentable(presentable)
        
        pushViewController(destination, animated: animated)
    }
    
    /// Presents a view from bottom to top
    func present(
        _ presentable: Presentable,
        animated: Bool = true
    ) {
        let destination = resolvePresentable(presentable)
        
        present(destination, animated: animated, completion: nil)
    }
    
    /// Presents a view in full screen mode from bottom to top
    func presentFullScreen(
        _ presentable: Presentable,
        animated: Bool = true
    ) {
        let destination = resolvePresentable(presentable)
        
        let navigationController = UINavigationController(rootViewController: destination)
        navigationController.modalPresentationStyle = .fullScreen
        navigationController.navigationBar.isHidden = true
        present(navigationController, animated: animated, completion: nil)
        presentNavigationController = navigationController
    }
    
    /// Pushes a view controller on the stack when in a presented state (right to left)
    func pushToPresent(
        _ presentable: Presentable,
        animated: Bool = true
    ) {
        let destination = resolvePresentable(presentable)
        
        presentNavigationController?.pushViewController(destination, animated: animated)
    }
    
    /// Presents a bottom sheet
    func bottomSheet(
        _ presentable: Presentable,
        animated: Bool = true
    ) {
        let destination = resolvePresentable(presentable)
        
        if #available(iOS 15.0, *) {
            destination.modalPresentationStyle = .pageSheet
        } else {
            destination.modalPresentationStyle = .formSheet
        }
        present(destination, animated: animated, completion: nil)
    }
}
