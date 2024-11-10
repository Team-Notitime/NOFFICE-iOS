//
//  AppleSignInButton.swift
//  SignupPresent
//
//  Created by DOYEON LEE on 7/10/24.
//

import UIKit
import AuthenticationServices

import RxSwift
import RxCocoa
import SnapKit
import Then

final public class AppleSignInButton: UIButton {
    // MARK: Component
    private lazy var signinButton =  ASAuthorizationAppleIDButton(
        type: .signIn,
        style: .black
    ).then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.isUserInteractionEnabled = false
    }
    
    // MARK: DisposeBag
    private let disposeBag = DisposeBag()
    
    // MARK: Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupHierarchy()
        setupLayout()
        setupBind()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupHierarchy()
        setupLayout()
        setupBind()
    }
    
    // MARK: Setup
    private func setupHierarchy() {
        self.addSubview(signinButton)
    }
    
    private func setupLayout() {
        signinButton.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func setupBind() { }
}
