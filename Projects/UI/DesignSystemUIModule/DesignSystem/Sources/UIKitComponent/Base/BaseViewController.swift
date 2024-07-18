//
//  BaseViewController.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 2023/05/30.
//

import UIKit

import RxSwift

protocol BaseViewControllerProtocol: AnyObject {
    func setupViewBind()
    func setupStateBind()
    func setupActionBind()
}

open class BaseViewController<View: BaseView>: UIViewController, BaseViewControllerProtocol {
    public var disposeBag = DisposeBag()
    
    public var baseView: View {
        return view as! View
    }
    
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func loadView() {
        view = View()
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        // Enable swipe back gesture when navigation bar is hidden
        navigationController?.interactivePopGestureRecognizer?.delegate = nil

        setupViewBind()
        setupStateBind()
        setupActionBind()
        setupHideKeyboardOnTap()
    }
    
    open func setupViewBind() { }
    
    open func setupStateBind() { }
    
    open func setupActionBind() { }
    
    // MARK: - Keyboard event
    private func setupHideKeyboardOnTap() {
        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(hideKeyboard)
        )
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func hideKeyboard() {
        view.endEditing(true)
    }
}
