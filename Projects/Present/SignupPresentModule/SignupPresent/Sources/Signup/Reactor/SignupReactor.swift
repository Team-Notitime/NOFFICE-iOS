//
//  SignupReactor.swift
//  SignupPresent
//
//  Created by DOYEON LEE on 8/14/24.
//

import Foundation

import KeychainUtility
import MainUsecase
import Router

import ReactorKit

class SignupReactor: Reactor {
    // MARK: Action
    enum Action { 
        case tapAppleSigninButton
        case fetchMemberInfo
    }
    
    enum Mutation { }
    
    // MARK: State
    struct State { }
    
    let initialState: State = State()
    
    // MARK: ChildReactor
    
    // MARK: Dependency
    private let appleLoginUsecase = AppleLoginUsecase()
    private let memberUsecase = GetMemberUsecase()
    
    // MARK: DisposeBag
    private let disposeBag = DisposeBag()
    
    // MARK: Initializer
    init() { }
    
    // MARK: Action operation
    func mutate(action: Action) -> Observable<Mutation> {
        switch action { 
        case .tapAppleSigninButton:
            let appleLoginExecuted = appleLoginUsecase
                .execute(.init())
                .flatMap { result in
                  switch result.isSuccess {
                  case .isAlreadyMember:
                    return self.mutate(action: .fetchMemberInfo)
                  case .requiredSignup:
                    DispatchQueue.main.async {
                      Router.shared.pushToPresent(SignupFunnelViewController(), animated: true)
                    }
                    return Observable<Mutation>.empty()
                  }
                }
            
            return appleLoginExecuted
        case .fetchMemberInfo:
          return memberUsecase
            .execute(.init())
            .do { _ in
              DispatchQueue.main.async {
                Router.shared.dismiss()
              }
            }
            .flatMap { _ in Observable<Mutation>.empty() }
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
