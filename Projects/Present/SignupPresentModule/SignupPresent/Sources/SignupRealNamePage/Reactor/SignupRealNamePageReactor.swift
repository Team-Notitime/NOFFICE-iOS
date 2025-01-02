//
//  SignupRealNameReactor.swift
//  SignupPresent
//
//  Created by DOYEON LEE on 7/18/24.
//

import Foundation

import ReactorKit
import MainUsecase

class SignupRealNamePageReactor: Reactor {
    // MARK: Action
    enum Action { 
        case changeName(String)
        case tapCompleteButton
    }
    
    enum Mutation {
        case setName(String)
    }
    
    // MARK: State
    struct State { 
        var name: String = ""
        var completeButtonActive: Bool = false
    }
  
    let initialState: State = State()
  
    // MARK: Dependency
    private let renameUsecase: RenameUsecase = RenameUsecase()
    
    // MARK: DisposeBag
    private let disposeBag = DisposeBag()
    
    // MARK: Initializer
    init() { }
    
    // MARK: Action operation
    func mutate(action: Action) -> Observable<Mutation> {
        switch action { 
        case let .changeName(name):
            return .just(.setName(name))
            
        case .tapCompleteButton:
            let name = currentState.name
            let renameExecuted = renameUsecase
                .execute(.init(name: name))
                .flatMap { _ in
                    return Observable<Mutation>.empty()
                }
            
            return renameExecuted
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case let .setName(name):
            state.name = name
            state.completeButtonActive = !name.isEmpty
        }
        return state
    }
}
