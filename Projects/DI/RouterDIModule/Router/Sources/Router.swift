//
//  Router.swift
//  Router
//
//  Created by DOYEON LEE on 7/2/24.
//

import Foundation
import UIKit

@MainActor
final public class Router: UINavigationController {
    public static let shared = Router()
    
    var presentNavigationController: UINavigationController?
    
    public var resolvePresentable: (Routable) -> UIViewController = { _ in
        fatalError("""
                    `resolvePresentable` must be set before using Router.
                    Check the RouterConfig in main app target.
                    """)
    }
    
    private init() {
        super.init(nibName: nil, bundle: nil)
        configure()
    }
    
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        setNavigationBarHidden(true, animated: false)
    }
    
    // MARK: Push
    /// Pushes a view from right to left
    public func push(
        _ destination: UIViewController,
        animated: Bool = true
    ) {
        pushViewController(destination, animated: animated)
    }
    
    /// Pops the top view controller from the navigation stack
    public func back(animated: Bool = true) {
        if !viewControllers.isEmpty {
            popViewController(animated: animated)
        }
    }
    
    /// Pops all the view controllers on the stack except the root view controller
    public func backToRoot(animated: Bool = true) {
        popToRootViewController(animated: animated)
    }
    
    // MARK: Present
    /// Presents a view from bottom to top
    public func present(
        _ viewController: UIViewController,
        animated: Bool = true
    ) {
        present(viewController, animated: animated, completion: nil)
    }
    
    /// Presents a view in full screen mode from bottom to top
    public func presentFullScreen(
        _ destination: UIViewController,
        animated: Bool = true
    ) {
        let navigationController = UINavigationController(rootViewController: destination)
        navigationController.modalPresentationStyle = .fullScreen
        navigationController.navigationBar.isHidden = true
        present(navigationController, animated: animated, completion: nil)
        presentNavigationController = navigationController
    }
    
    /// Pushes a view controller on the stack when in a presented state (right to left)
    public func pushToPresent(
        _ destination: UIViewController,
        animated: Bool = true
    ) {
        presentNavigationController?.pushViewController(destination, animated: animated)
    }
    
    /// Dismisses the presented view
    public func dismiss(animated: Bool = true) {
        if !viewControllers.isEmpty {
            dismiss(animated: animated, completion: nil)
        }
        
        presentNavigationController = nil
    }
    
    /// Pops the top view controller in the presented view
    public func backToPresented() {
        presentNavigationController?.popViewController(animated: true)
    }
    
    /// Presents a bottom sheet
    public func bottomSheet(
        _ destination: UIViewController,
        animated: Bool = true
    ) {
        if #available(iOS 15.0, *) {
            destination.modalPresentationStyle = .pageSheet
        } else {
            destination.modalPresentationStyle = .formSheet
        }
        present(destination, animated: animated, completion: nil)
    }
    
    // MARK: Web view
    /// Presents a web view
    public func presentWebView(
        _ url: URL,
        isSafariButtonHidden: Bool = false
    ) {
        let viewController = WebViewController(
            url: url,
            isSafariButtonHidden: isSafariButtonHidden
        )
        present(viewController, animated: true, completion: nil)
    }
}
