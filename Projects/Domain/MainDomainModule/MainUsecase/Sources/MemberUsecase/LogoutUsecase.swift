//
//  LogoutUsecase.swift
//  MemberUsecase
//
//  Created by DOYEON LEE on 8/17/24.
//

import KeychainUtility

import RxSwift

public struct LogoutUsecase {
    // MARK: DTO
    public struct Input { 
        public init() { }
    }
    
    public struct Output { }
    
    // MARK: Dependency
    private let tokenKeychainManager = KeychainManager<Token>()
    
    // MARK: Initializer
    public init() { }
    
    // MARK: Execute method
    public func execute(_ input: Input) -> Observable<Output> {
        tokenKeychainManager.delete()
        
        return .just(.init())
    }
}
