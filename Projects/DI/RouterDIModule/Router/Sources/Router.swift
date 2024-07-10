//
//  Router.swift
//  Router
//
//  Created by DOYEON LEE on 7/2/24.
//

import UIKit

final public class Router {
    public static let shared = Router()
    
    public var root = UINavigationController()
    
    private init() {}
    
    public func push(_ destination: UIViewController) {
        root.pushViewController(destination, animated: true)
    }
    
    public func back() {
        root.popViewController(animated: true)
    }
    
    public func backToRoot() {
        root.popToRootViewController(animated: true)
    }
    
    public func present(_ viewController: UIViewController) {
        root.present(viewController, animated: true, completion: nil)
    }
    
    public func dismiss() {
        root.dismiss(animated: true, completion: nil)
    }
}
