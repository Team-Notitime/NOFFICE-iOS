//
//  NewOrganizationPromotionPageReactor.swift
//  OrganizationPresent
//
//  Created by DOYEON LEE on 7/20/24.
//

import ReactorKit

class NewOrganizationPromotionPageReactor: Reactor {
    // MARK: Action
    enum Action {
        case changePromotionCode(String)
        case tapCompleteButton
    }
    
    enum Mutation {
        case setName(String)
    }
    
    // MARK: State
    struct State {
        var promotionCode: String = ""
        var completePageButtonActive: Bool = true
    }
    
    let initialState: State = State()
    
    // MARK: DisposeBag
    private let disposeBag = DisposeBag()
    
    // MARK: Initializer
    init() { }
    
    // MARK: Action operation
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case let .changePromotionCode(promotionCode):
            return .just(.setName(promotionCode))
            
        case .tapCompleteButton:
            // pass to parent
            return .empty()
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case let .setName(promotionCode):
            state.promotionCode = promotionCode
            state.completePageButtonActive = true // TODO: 추후 규칙 추가
        }
        return state
    }
}
