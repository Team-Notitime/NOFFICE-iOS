//
//  NewOrganizationPromotionPageReactor.swift
//  OrganizationPresent
//
//  Created by DOYEON LEE on 7/20/24.
//

import ReactorKit
import MainUsecase

class NewOrganizationPromotionPageReactor: Reactor {
    // MARK: Action
    enum Action {
        case changePromotionCode(String)
        case tapCompleteButton
    }
    
    enum Mutation {
        case setName(String)
        case setPageButtonActive(Bool)
        case setPromotionValidity(Bool)
    }
    
    // MARK: State
    struct State {
        var promotionCode: String = ""
        var promotionisValid: Bool?
        var completePageButtonActive: Bool = true
    }
    
    let initialState: State = State()
    
    // MARK: DisposeBag
    private let disposeBag = DisposeBag()
    
    // MARK: Initializer
    init() { }
  
    // MARK: Dependency
    private let verifyPromotionUsecase = VerifyPromotionUsecase()
    
    // MARK: Action operation
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case let .changePromotionCode(promotionCode):
          print("프로모션 코드 \(promotionCode)")
          if promotionCode.isEmpty {
              // 프로모션 코드가 비어있으면 버튼 활성화 + 이름 설정
              return .concat([
                  .just(.setPageButtonActive(true)),
                  .just(.setName(promotionCode))
              ])
          } else {
              // 프로모션 코드가 있으면 검증 후 버튼 상태 설정 + 이름 설정
              return .concat([
                  verifyPromotionUsecase.execute(.init(promotionCode: promotionCode))
                      .flatMap { output -> Observable<Mutation> in
                        return .concat([
                          .just(.setPageButtonActive(output.isValid)),
                          .just(.setPromotionValidity(output.isValid))
                        ])
                      }
                      .catch { _ in
                          return .just(.setPageButtonActive(false))
                      }
                      .observe(on: MainScheduler.instance),
                  .just(.setName(promotionCode))
              ])
          }
            
        case .tapCompleteButton:
          return .empty()
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case let .setName(promotionCode):
            state.promotionCode = promotionCode
        case let .setPageButtonActive(isActive):
            state.completePageButtonActive = isActive
        case let .setPromotionValidity(isValid):
            state.promotionisValid = isValid
        }
        return state
    }
}
