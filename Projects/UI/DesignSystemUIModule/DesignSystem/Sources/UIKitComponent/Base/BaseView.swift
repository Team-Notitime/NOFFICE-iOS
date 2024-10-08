//
//  BaseView.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 2023/05/30.
//

import UIKit

import Assets

import RxSwift

public protocol BaseViewProtocol {
    func setupHierarchy()
    func setupLayout()
}

open class BaseView: UIView, BaseViewProtocol {
    public var disposeBag = DisposeBag()
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .fullWhite

        setupHierarchy()
        setupLayout()
    }

    open func setupHierarchy() { }
    
    open func setupLayout() { }
}
