//
//  GetMemberUsecase.swift
//  MemberEntity
//
//  Created by DOYEON LEE on 8/2/24.
//

import Foundation

import MainEntity
import UserDefaultsUtility

import RxSwift
import MemberDataInterface
import Swinject

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
        case invalidResponse
        case memberNotFoundInUserDefaults
        case notExistingMember
    }
    
    // MARK: Dependency
    private let memberRepository = Container.shared.resolve(MemberRepositoryInterface.self)!
  
    // MARK: Initializer
    public init() { }
    
    // MARK: Execute method
    public func execute(_ input: Input) -> Observable<Output> {
      return memberRepository.getMember(.init())
        .map { member in
          guard let id = member.id,
                let name = member.name else {
            throw Error.invalidResponse
          }
          
          let memberEntity = MemberEntity(
            uid: id,
            name: name,
            email: "",
            profileImageURL: member.profileImage
          )
          
          return Output(member: memberEntity)
        }
        .catch { _ in 
          return .error(Error.notExistingMember)
        }
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
