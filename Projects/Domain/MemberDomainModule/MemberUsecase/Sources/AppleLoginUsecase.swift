//
//  AppleLoginUsecase.swift
//  MemberUsecase
//
//  Created by DOYEON LEE on 8/14/24.
//

import Container
import MemberEntity
import MemberDataInterface

import Swinject
import RxSwift

public struct AppleLoginUsecase {
    // MARK: DTO
    public struct Input {
        let authorizationCode: String // TODO: 추후 가능하면 identityToken으로 변경
        
        public init(
            authorizationCode: String
        ) {
            self.authorizationCode = authorizationCode
        }
    }
    
    public struct Output { }
    
    // MARK: Dependency
    let memberRepository = Container.shared.resolve(MemberRepositoryInterface.self)!
    
    // MARK: Initializer
    public init() { }
    
    // MARK: Execute method
    public func execute(_ param: Input) -> Observable<Output> {
        let requestParam: LoginParam = .init(
            body: .json(
                .init(
                    provider: .APPLE,
                    code: param.authorizationCode
                )
            )
        )
        
        return memberRepository.login(requestParam)
            .map { _ in Output() }
    }
}
