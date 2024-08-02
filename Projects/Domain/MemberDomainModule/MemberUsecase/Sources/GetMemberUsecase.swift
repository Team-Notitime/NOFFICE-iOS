//
//  GetMemberUsecase.swift
//  MemberEntity
//
//  Created by DOYEON LEE on 8/2/24.
//

import MemberEntity

import RxSwift

public struct GetMemberUsecase {
    
    public init() { }
    
    public func execute() -> Observable<MemberEntity> {
        return .just(Self.mock)
    }
    
    static let mock = MemberEntity(
        uid: 1,
        name: "노띠",
        email: "notti@gmail.com"
    )
}
