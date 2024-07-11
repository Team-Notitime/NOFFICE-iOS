//
//  ViewController.swift
//  Noffice
//
//  Created by DOYEON LEE on 7/1/24.
//

import UIKit
import AuthenticationServices

import SignupPresent

import RxSwift
import Router
import SnapKit

/// Apple signin test view
class ViewController: UIViewController{
    let button: UIButton = UIButton()
    let appleSigninButton = AppleSignInButton()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        // 버튼 속성 설정
        button.setTitle("Go to Next Page", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        // 버튼 추가 및 레이아웃 설정
        view.addSubview(button)
        button.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalTo(100)
            make.leading.trailing.equalToSuperview().inset(12)
        }
        
        view.addSubview(appleSigninButton)
        appleSigninButton.snp.makeConstraints { make in
            make.top.equalTo(button.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview().inset(12)
            make.height.equalTo(100)
        }
        
        bind()
    }
    
    @objc func buttonTapped() {
        Router.shared.push(TestCompositionalLayoutViewController())
    }
    
    func bind() {
        appleSigninButton.authorizationDidComplete
            .subscribe(onNext: { authorization in
                switch authorization.credential {
                case let appleIDCredential as ASAuthorizationAppleIDCredential:
                    
                    // Create an account in your system.
                    let userIdentifier = appleIDCredential.user
                    let fullName = appleIDCredential.fullName
                    let email = appleIDCredential.email
                    
                    // For the purpose of this demo app, store the `userIdentifier` in the keychain.
                    print("userIdentifier: \(userIdentifier), fullName: \(fullName), email: \(String(describing: email))")
                    
                    if  let authorizationCode = appleIDCredential.authorizationCode,
                        let identityToken = appleIDCredential.identityToken,
                        let authString = String(data: authorizationCode, encoding: .utf8),
                        let tokenString = String(data: identityToken, encoding: .utf8) {
                        print("authorizationCode: \(authorizationCode)")
                        print("identityToken: \(identityToken)")
                        print("authString: \(authString)")
                        print("tokenString: \(tokenString)")
                    }
                    
                case let passwordCredential as ASPasswordCredential:
                    
                    // Sign in using an existing iCloud Keychain credential.
                    let username = passwordCredential.user
                    let password = passwordCredential.password
                    
                    print("username: \(username), password: \(password)")
                    
                default: break
                }
            }).disposed(by: disposeBag)
    }
}
