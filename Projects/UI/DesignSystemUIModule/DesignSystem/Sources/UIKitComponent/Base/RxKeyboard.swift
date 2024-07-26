//
//  RxKeyboard.swift
//  DesignSystem
//
//  Created by DOYEON LEE on 7/25/24.
//

import UIKit

import RxSwift
import RxCocoa

public class RxKeyboard {
    public static let shared = RxKeyboard()
    
    private let disposeBag = DisposeBag()
    
    private let keyboardSizeRelay = BehaviorRelay<CGRect>(value: .zero)
    
    public var keyboardSize: Observable<CGRect> {
        return keyboardSizeRelay.asObservable()
    }
    
    private init() {
        NotificationCenter.default.rx.notification(UIResponder.keyboardWillShowNotification)
            .compactMap { notification -> CGRect? in
                guard let userInfo = notification.userInfo,
                      let keyboardFrame = userInfo[
                        UIResponder.keyboardFrameEndUserInfoKey
                      ] as? CGRect else {
                    return nil
                }
                return keyboardFrame
            }
            .bind(to: keyboardSizeRelay)
            .disposed(by: disposeBag)
        
        NotificationCenter.default.rx.notification(UIResponder.keyboardWillHideNotification)
            .map { _ -> CGRect in
                return .zero
            }
            .bind(to: keyboardSizeRelay)
            .disposed(by: disposeBag)
    }
}
