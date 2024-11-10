//
//  SignupReactor.swift
//  SignupPresent
//
//  Created by DOYEON LEE on 8/14/24.
//

import Foundation

import KeychainUtility
import MemberUsecase
import Router

import ReactorKit

class SignupReactor: Reactor {
    // MARK: Action
    enum Action {
        case tapAppleSigninButton
        case tapKakaoSigninButton
    }
    
    enum Mutation { }
    
    // MARK: State
    struct State { }
    
    let initialState: State = State()
    
    // MARK: ChildReactor
    
    // MARK: Dependency
    private let appleLoginUsecase = AppleLoginUsecase()
    
    private let kakaoLoginUsecase = KakaoLoginUsecase()
    
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
                    if result.isSuccess {
                        DispatchQueue.main.async {
                            Router.shared.dismiss()
                        }
                    } else {
                        // TODO: Error dialog 처리하기
                    }
                    return Observable<Mutation>.empty()
                }
            
            return appleLoginExecuted
        case .tapKakaoSigninButton:
            let kakaoLoginExecuted = kakaoLoginUsecase
                .execute(.init())
                .flatMap { _ in
                    print("::: 해치웠나")
                    return Observable<Mutation>.empty()
                }

            return kakaoLoginExecuted
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
