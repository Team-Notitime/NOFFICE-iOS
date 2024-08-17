//
//  MypageReactor.swift
//  MypagePresent
//
//  Created by DOYEON LEE on 8/2/24.
//

import Foundation

import MemberUsecase
import Router

import ReactorKit

class MypageReactor: Reactor {
    // MARK: Action
    enum Action { 
        case tapLogoutRow
    }
    
    enum Mutation { }
    
    // MARK: State
    struct State { }
    
    let initialState: State = State()
    
    // MARK: ChildReactor
    
    // MARK: Dependency
    private let logoutUsecase = LogoutUsecase()
    
    // MARK: DisposeBag
    private let disposeBag = DisposeBag()
    
    // MARK: Initializer
    init() { }
    
    // MARK: Action operation
    func mutate(action: Action) -> Observable<Mutation> {
        switch action { 
        case .tapLogoutRow:
            _ = logoutUsecase.execute(.init())
            
            DispatchQueue.main.async {
                Router.shared.back(animated: false)
                Router.shared.presentFullScreen(.signup, animated: false)
            }
            
            return .empty()
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation { }
        return state
    }
    
    // MARK: Child bind
    private func setupChildBind() { }
    
    // MARK: Transform
    
    // MARK: Private method
}
