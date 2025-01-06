//
//  VerifyPromotionUsecase.swift
//  MainDomainModule
//
//  Created by HUNHEE LEE on 3.01.2025.
//

import Container
import MainEntity
import OrganizationDataInterface

import Swinject
import RxSwift

public struct VerifyPromotionUsecase {
  // MARK: DTO
  public struct Input {
    public let promotionCode: String
    
    public init(
      promotionCode: String
    ) {
      self.promotionCode = promotionCode
    }
  }
  
  public struct Output {
    public let isValid: Bool
  }
  
  private let organizationRepository = Container.shared.resolve(OrganizationRepositoryInterface.self)!
  
  public init() { }
  
  // MARK: Execute ethod
  public func execute(_ input: Input) -> Observable<Output> {
    let outputObservable = organizationRepository.verifyPromotion(
      .init(body: .init(promotionCode: input.promotionCode))
      )
      .map { _ in
        return Output(isValid: true)
      }
      .catch { _ in
        return .just(Output(isValid: false))
      }
    
    return outputObservable
  }
}
