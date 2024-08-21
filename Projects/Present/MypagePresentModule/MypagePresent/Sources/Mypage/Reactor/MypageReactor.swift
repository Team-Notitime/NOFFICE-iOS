//
//  MypageReactor.swift
//  MypagePresent
//
//  Created by DOYEON LEE on 8/2/24.
//

import Foundation

import MemberUsecase
import Router
import UserDefaultsUtility

import ReactorKit

class MypageReactor: Reactor {
    // MARK: Action
    enum Action { 
        case viewDidLoad
        case tapLogoutRow
    }
    
    enum Mutation { 
        case setMember(Member?)
    }
    
    // MARK: State
    struct State { 
        var member: Member?
    }
    
    let initialState: State = State()
    
    // MARK: ChildReactor
    
    // MARK: Dependency
    private let memberUserDefaultsManager = UserDefaultsManager<Member>()
    
    private let logoutUsecase = LogoutUsecase()
    
    // MARK: DisposeBag
    private let disposeBag = DisposeBag()
    
    // MARK: Initializer
    init() { }
    
    // MARK: Action operation
    func mutate(action: Action) -> Observable<Mutation> {
        switch action { 
        case .viewDidLoad:
            let member = memberUserDefaultsManager.get()
            return .just(.setMember(member))
            
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
        switch mutation { 
        case let .setMember(member):
            state.member = member
        }
        return state
    }
    
    // MARK: Child bind
    private func setupChildBind() { }
    
    // MARK: Transform
    
    // MARK: Private method
}
