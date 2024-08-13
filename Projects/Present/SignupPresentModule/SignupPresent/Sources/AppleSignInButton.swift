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

// TODO: authorization 로직 UI 코드와 분리 필요
final public class AppleSignInButton: UIButton {
    // MARK: Property
    private var authorizationController: ASAuthorizationController = {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        return ASAuthorizationController(authorizationRequests: [request])
    }()
    
    // MARK: Delegate to Rx
    private let _authorizationDidComplete = PublishRelay<ASAuthorization>()
    private let _authorizationDidFail = PublishRelay<Error>()
    
    public var authorizationDidComplete: Observable<ASAuthorization> {
        return _authorizationDidComplete.asObservable()
    }
    
    public var authorizationDidFail: Observable<Error> {
        return _authorizationDidFail.asObservable()
    }
    
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
        setupDelegate()
        setupHierarchy()
        setupLayout()
        setupBind()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupDelegate()
        setupHierarchy()
        setupLayout()
        setupBind()
    }
    
    // MARK: Setup
    private func setupDelegate() {
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
    }
    
    private func setupHierarchy() {
        self.addSubview(signinButton)
    }
    
    private func setupLayout() {
        signinButton.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func setupBind() {
        self.rx.tap
            .debug()
            .bind { [weak self] in
                self?.authorizationController.performRequests()
            }
            .disposed(by: disposeBag)
    }
}

// MARK: - Delegate
extension AppleSignInButton: ASAuthorizationControllerDelegate, 
                                ASAuthorizationControllerPresentationContextProviding {
    public func authorizationController(
        controller: ASAuthorizationController,
        didCompleteWithAuthorization authorization: ASAuthorization
    ) {
        _authorizationDidComplete.accept(authorization)
    }
    
    public func authorizationController(
        controller: ASAuthorizationController,
        didCompleteWithError error: Error
    ) {
        _authorizationDidFail.accept(error)
    }
    
    public func presentationAnchor(
        for controller: ASAuthorizationController
    ) -> ASPresentationAnchor {
        return UIApplication.shared.windows.first { $0.isKeyWindow }!
    }
}
