//
//  SignupRealNameReactor.swift
//  SignupPresent
//
//  Created by DOYEON LEE on 7/18/24.
//

import Foundation

import ReactorKit

class SignupRealNameReactor: Reactor {
    // MARK: Action
    enum Action { 
        case changeName(String)
        case tapCompleteButton
    }
    
    enum Mutation {
        case setName(String)
        case changecompleteButtonActive(String)
    }
    
    // MARK: State
    struct State { 
        var name: String = ""
        var completeButtonActive: Bool = false
    }
    
    let initialState: State = State()
    
    // MARK: Dependency
    
    // MARK: DisposeBag
    private let disposeBag = DisposeBag()
    
    // MARK: Initializer
    init() { }
    
    // MARK: Action operation
    func mutate(action: Action) -> Observable<Mutation> {
        switch action { 
        case let .changeName(name):
            return .merge(
                .just(.setName(name)),
                .just(.changecompleteButtonActive(name))
            )
            
        case .tapCompleteButton:
            // pass to parent
            return .empty()
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation { 
        case let .setName(name):
            state.name = name
            
        case let .changecompleteButtonActive(name):
            state.completeButtonActive = !name.isEmpty
        }
        return state
    }
    
    // MARK: Transform
    
    // MARK: Private method
}
