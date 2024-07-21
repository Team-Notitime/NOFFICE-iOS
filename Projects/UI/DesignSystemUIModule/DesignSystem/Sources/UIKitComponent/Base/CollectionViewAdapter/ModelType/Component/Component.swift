//
//  Component.swift
//  AlamofirePractice
//
//  Created by 이숭인 on 6/13/24.
//

import Foundation
import UIKit
import RxSwift

public protocol Component: ItemModelType {
    associatedtype Content: UIView
    associatedtype Context: Component
    
    var viewType: ViewType { get }
    
    func createContent() -> Content
    func prepareForReuse(content: Content)
    func render(content: Content, context: Context)
    func render(content: Content, context: Context, disposeBag: inout DisposeBag)
}

// MARK: - ViewType
extension Component {
    public var viewType: ViewType { .type(ComponentContainerCell<Context>.self) }
}

// MARK: - Render
extension Component {
    public func createContent() -> Content { Content() }
    public func prepareForReuse(content: Content) { }
    public func render(content: Content, context: Context) { }
    public func render(content: Content, context: Context, disposeBag: inout DisposeBag) {
        render(content: content, context: context)
    }
}
