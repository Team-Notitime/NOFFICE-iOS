//
//  SignupReactor.swift
//  SignupPresent
//
//  Created by DOYEON LEE on 8/14/24.
//

import MemberUsecase

import ReactorKit

class SignupReactor: Reactor {
    // MARK: Action
    enum Action { 
        case completeAppleLogin(authorizationCode: String)
    }
    
    enum Mutation { }
    
    // MARK: State
    struct State { }
    
    let initialState: State = State()
    
    // MARK: ChildReactor
    
    // MARK: Dependency
    private let appleLoginUsecase = AppleLoginUsecase()
    
    // MARK: DisposeBag
    private let disposeBag = DisposeBag()
    
    // MARK: Initializer
    init() { }
    
    // MARK: Action operation
    func mutate(action: Action) -> Observable<Mutation> {
        switch action { 
        case let .completeAppleLogin(authorizationCode):
            
            return appleLoginUsecase
                .execute(
                    .init(
                        authorizationCode: authorizationCode
                    )
                )
                .debug()
                .flatMap { _ in
                    Observable<Mutation>.empty() // TODO: navigation 처리
                }
            
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation { 
            
        }
        return state
    }
    
    // MARK: Child bind
    private func setupChildBind() { }
    
    // MARK: Transform
    
    // MARK: Private method
}
