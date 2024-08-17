//
//  AppleLoginUsecase.swift
//  MemberUsecase
//
//  Created by DOYEON LEE on 8/14/24.
//

import Foundation
import AuthenticationServices

import Container
import MemberEntity
import MemberDataInterface
import KeychainUtility
import UserDefaultsUtility

import Swinject
import RxSwift

/// 애플 로그인을 시도하고 로그인에 성공하면 서버에서 전달받은 accessToekn과 refreshToken을 Keychain에 저장합니다.
///
/// **[처리 과정]**
/// 1. 애플 로그인을 통해 사용자 식별자 (identity token)을 받습니다.
/// 2. identity token을 서버에 전달해 유저를 등록하고 accessToken과 refreshToken을 받습니다.
public final class AppleLoginUsecase: NSObject {
    // MARK: DTO
    public struct Input {
        public init() { }
    }
    
    public struct Output {
        /// 로그인 성공 여부 입니다.
        ///
        /// 성공시 ture를 반환하고, 실패 시엔 Observable error가 방출됩니다.
        public let isSuccess: Bool
    }
    
    // MARK: Error
    public enum Error: LocalizedError {
        case invalidToken
        
        public var errorDescription: String? {
            switch self {
            case .invalidToken:
                return "The token is invalid."
            }
        }
    }
    
    // MARK: Dependency
    let memberRepository = Container.shared.resolve(MemberRepositoryInterface.self)!
    
    let keychainManager = KeychainManager<Token>()
    
    let userDefaultsManager = UserDefaultsManager<Member>()
    
    private var authorizationController: ASAuthorizationController = {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        return ASAuthorizationController(authorizationRequests: [request])
    }()
    
    private let authorizationResultSubject = PublishSubject<Output>()
    
    // MARK: DisposeBag
    private let disposeBag = DisposeBag()
    
    // MARK: Initializer
    public override init() {
        super.init()
        
        setupDelegate()
    }
    
    // MARK: Execute method
    public func execute(_ param: Input) -> Observable<Output> {
        self.authorizationController.performRequests()
        
        return authorizationResultSubject.asObservable()
    }
}

// MARK: - Private method
extension AppleLoginUsecase {
    private func setupDelegate() {
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
    }
    
    private func saveToKeychain(accessToken: String, refreshToken: String) {
        let token = Token(accessToken: accessToken, refreshToken: refreshToken)
        keychainManager.save(token)
    }
    
    private func saveToUserDefaults(result: LoginResult) {
        if let id = result.memberId,
           let name = result.memberName,
           let provider = result.provider {
            let member = Member(
                id: id, name: name,
                provider: provider.rawValue
            )
            userDefaultsManager.save(member)
        }
    }
}

// MARK: - Delegate
extension AppleLoginUsecase: ASAuthorizationControllerDelegate,
                                ASAuthorizationControllerPresentationContextProviding {
    public func authorizationController(
            controller: ASAuthorizationController,
            didCompleteWithAuthorization authorization: ASAuthorization
        ) {
            guard let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential,
                  let identityTokenData = appleIDCredential.identityToken,
                  let identityToken = String(data: identityTokenData, encoding: .utf8) else {
                authorizationResultSubject.onError(Error.invalidToken)
                return
            }
            
            let requestParam: LoginParam = .init(
                body: .json(
                    .init(
                        provider: .APPLE,
                        code: identityToken
                    )
                )
            )
            
            memberRepository.login(requestParam)
                .flatMap { [weak self] result -> Observable<Output> in
                    guard let self = self else { return Observable.empty() }
                    if let accessToken = result.token?.accessToken,
                       let refreshToken = result.token?.refreshToken {
                        self.saveToKeychain(accessToken: accessToken, refreshToken: refreshToken)
                        self.saveToUserDefaults(result: result)
                        return Observable.just(Output(isSuccess: true))
                    } else {
                        return Observable.error(Error.invalidToken)
                    }
                }
                .debug()
                .subscribe(onNext: { [weak self] output in
                    self?.authorizationResultSubject.onNext(output)
                }, onError: { [weak self] error in
                    self?.authorizationResultSubject.onError(error)
                })
                .disposed(by: disposeBag)
        }
        
        public func authorizationController(
            controller: ASAuthorizationController,
            didCompleteWithError error: Swift.Error
        ) {
            authorizationResultSubject.onError(error)
        }
    
    public func presentationAnchor(
        for controller: ASAuthorizationController
    ) -> ASPresentationAnchor {
        let windowScene = UIApplication.shared.connectedScenes
            .first { $0.activationState == .foregroundActive } as? UIWindowScene

        return windowScene?.windows.first { $0.isKeyWindow } ?? UIWindow()
    }
}
