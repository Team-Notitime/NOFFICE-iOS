//
//  GetMemberUsecase.swift
//  MemberEntity
//
//  Created by DOYEON LEE on 8/2/24.
//

import Foundation

import MemberEntity
import UserDefaultsUtility

import RxSwift

public struct GetMemberUsecase {
    // MARK: DTO
    public struct Input {
        public init() { }
    }
    
    public struct Output {
        public let member: MemberEntity
    }
    
    // MARK: Error
    public enum Error: LocalizedError {
        case memberNotFoundInUserDefaults
    }
    
    // MARK: Dependency
    private let memberUserDefaultsManager = UserDefaultsManager<Member>()
    
    // MARK: Initializer
    public init() { }
    
    // MARK: Execute method
    public func execute(_ input: Input) -> Observable<Output> {
        let member = memberUserDefaultsManager.get()
        
        let observable = Observable.create { observer in
            if let member = member {
                let memberEntity = MemberEntity(
                    uid: member.id,
                    name: member.name,
                    email: "" // TODO:
                )
                observer.onNext(Output(member: memberEntity))
            } else {
                observer.onError(Error.memberNotFoundInUserDefaults)
            }
            return Disposables.create()
        }
        
        return observable
    }
}

// MARK: - Mcok
private struct Mock {
    static let memberEntity = MemberEntity(
        uid: 1,
        name: "노띠",
        email: "notti@gmail.com"
    )
}
