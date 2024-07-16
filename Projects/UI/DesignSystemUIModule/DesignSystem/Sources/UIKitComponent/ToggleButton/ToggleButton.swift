//
//  ToggleButton.swift
//  DesignSystem
//
//  Created by DOYEON LEE on 7/16/24.
//

import UIKit

import RxSwift

public protocol ToggleButton: UIControl {
    associatedtype Option: Equatable & Identifiable
    
    var onChangeSelected: Observable<Bool> { get }
    var value: Option? { get }
}
