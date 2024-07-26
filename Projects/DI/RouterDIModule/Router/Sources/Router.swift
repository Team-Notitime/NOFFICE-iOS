//
//  Router.swift
//  Router
//
//  Created by DOYEON LEE on 7/2/24.
//

import UIKit

final public class Router: UINavigationController {
    public static let shared = Router()
    
    private var presentNavigationController: UINavigationController?
    
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
        pushViewController(destination, animated: true)
    }
    
    /// Pops the top view controller from the navigation stack
    public func back() {
        if !viewControllers.isEmpty {
            popViewController(animated: true)
        }
    }
    
    /// Pops all the view controllers on the stack except the root view controller
    public func backToRoot() {
        popToRootViewController(animated: true)
    }
    
    // MARK: Present
    /// Presents a view from bottom to top
    public func present(_ viewController: UIViewController) {
        present(viewController, animated: true, completion: nil)
    }
    
    /// Presents a view in full screen mode from bottom to top
    public func presentFullScreen(_ viewController: UIViewController) {
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.modalPresentationStyle = .fullScreen
        navigationController.navigationBar.isHidden = true
        present(navigationController, animated: true, completion: nil)
        presentNavigationController = navigationController
    }
    
    /// Pushes a view controller on the stack when in a presented state (right to left)
    public func pushToPresent(
        _ viewController: UIViewController
    ) {
        presentNavigationController?.pushViewController(viewController, animated: true)
    }
    
    /// Dismisses the presented view
    public func dismiss() {
        if !viewControllers.isEmpty {
            dismiss(animated: true, completion: nil)
        }
        
        presentNavigationController = nil
    }
    
    /// Pops the top view controller in the presented view
    public func backToPresented() {
        presentNavigationController?.popViewController(animated: true)
    }
    
    /// Presents a bottom sheet
    public func bottomSheet(_ viewController: UIViewController) {
        if #available(iOS 15.0, *) {
            viewController.modalPresentationStyle = .pageSheet
        } else {
            viewController.modalPresentationStyle = .formSheet
        }
        present(viewController, animated: true, completion: nil)
    }
}
