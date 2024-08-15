//
//  SignupViewController.swift
//  SignupPresent
//
//  Created by DOYEON LEE on 7/17/24.
//

import UIKit

import Router
import DesignSystem
import Assets

import RxSwift
import RxCocoa
import Swinject
import AuthenticationServices

public class SignupViewController: BaseViewController<SignupView> {
    // MARK: Reactor
    private let reactor = Container.shared.resolve(SignupReactor.self)!
    
    // MARK: Setup
    public override func setupViewBind() {
        baseView.dummyButton
            .onTap
            .subscribe(onNext: {
                Router.shared.presentFullScreen(SignupFunnelViewController())
            })
            .disposed(by: disposeBag)
        
        baseView.appleSigninButton
            .authorizationDidComplete
            .subscribe(
                with: self,
                onNext: { owner, authorization in
                    switch authorization.credential {
                    case let appleIDCredential as ASAuthorizationAppleIDCredential:
                        
                        // Create an account in your system.
                        let userIdentifier = appleIDCredential.user
                        let fullName = appleIDCredential.fullName
                        let email = appleIDCredential.email
                        
                        // For the purpose of this demo app, store the `userIdentifier` in the keychain.
                        print("""
                                userIdentifier: \(userIdentifier),
                                fullName: \(String(describing: fullName)),
                                email: \(String(describing: email))
                                """)
                        
                        if  let authorizationCode = appleIDCredential.authorizationCode,
                            let identityToken = appleIDCredential.identityToken,
                            let authString = String(data: authorizationCode, encoding: .utf8),
                            let tokenString = String(data: identityToken, encoding: .utf8) {
                            print("authorizationCode: \(authorizationCode)")
                            print("identityToken: \(identityToken)")
                            print("authString: \(authString)")
                            print("tokenString: \(tokenString)")
                            
                            owner.reactor.action.onNext(.completeAppleLogin(authorizationCode: tokenString))
                        }
                        
                    case let passwordCredential as ASPasswordCredential:
                        
                        // Sign in using an existing iCloud Keychain credential.
                        let username = passwordCredential.user
                        let password = passwordCredential.password
                        
                        print("username: \(username), password: \(password)")
                        
                    default: break
                    }
                }
            )
            .disposed(by: disposeBag)
    }
    
    public override func setupStateBind() {
        
    }
    
    public override func setupActionBind() {
        
    }
}
