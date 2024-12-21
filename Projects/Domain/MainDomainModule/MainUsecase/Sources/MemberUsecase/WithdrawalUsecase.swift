//
//  WithdrawalUsecase.swift
//  MemberUsecase
//
//  Created by DOYEON LEE on 8/29/24.
//

import Container
import MemberDataInterface
import KeychainUtility

import Swinject
import RxSwift

public struct WithdrawalUsecase {
    // MARK: DTO
    public struct Input {
        public init() { }
    }
    
    public struct Output { 
        public let isSuccess: Bool
    }
    
    // MARK: Dependency
    private let memberRepository = Container.shared.resolve(MemberRepositoryInterface.self)!
    
    private let tokenKeychainManager = KeychainManager<Token>()
    
    // MARK: Initializer
    public init() { }
    
    // MARK: Execute method
    public func execute(_ input: Input) -> Observable<Output> {
        tokenKeychainManager.delete()
        
        let outputObservable = self.memberRepository
            .withdrawal(.init())
            .map { Output(isSuccess: true) }
        
        return outputObservable
    }
}
