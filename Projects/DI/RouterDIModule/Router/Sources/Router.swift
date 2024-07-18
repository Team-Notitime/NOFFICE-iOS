//
//  Router.swift
//  Router
//
//  Created by DOYEON LEE on 7/2/24.
//

import UIKit

final public class Router: UINavigationController {
    public static let shared = Router()
    
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
    
    public func push(_ destination: UIViewController) {
        pushViewController(destination, animated: true)
    }
    
    public func back() {
        popViewController(animated: true)
    }
    
    public func backToRoot() {
        popToRootViewController(animated: true)
    }
    
    public func present(_ viewController: UIViewController) {
        present(viewController, animated: true, completion: nil)
    }
    
    public func dismiss() {
        if viewControllers.count > 0 {
            dismiss(animated: true, completion: nil)
        }
    }
}
