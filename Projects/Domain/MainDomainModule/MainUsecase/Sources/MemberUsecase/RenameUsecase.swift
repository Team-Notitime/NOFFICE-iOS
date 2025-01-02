//
//  RenameUsecase.swift
//  MainDomainModule
//
//  Created by HUNHEE LEE on 27.12.2024.
//

import Container
import MemberDataInterface
import Swinject
import RxSwift

public struct RenameUsecase {
  // MARK: DTO
  public struct Input {
    let name: String
    
    public init(name: String) {
      self.name = name
    }
  }
  
  public struct Output { }
  
  // MARK: Dependency
  private let memberRepository: MemberRepositoryInterface = Container.shared.resolve(MemberRepositoryInterface.self)!
  
  // MARK: Initializer
  public init() { }
  
  // MAKR: Execute method
  public func execute(_ input: Input) -> Observable<Output> {
    let outputObservable = self.memberRepository
      .rename(.init(body: .json(.init(name: input.name))))
      .map { Output() }
    
    return outputObservable
  }
}
