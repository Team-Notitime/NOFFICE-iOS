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
import NotificationCenterUtility

import ReactorKit
import RxSwift

class MypageReactor: Reactor {
    // MARK: Action
    enum Action { 
        case viewDidLoad
        case tapLogoutRow
        case tapWithdrawRow
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
    
    private let notificationCenterManager = NotificationCenterManager<Void>(name: .tokenExpired)
    
    private let logoutUsecase = LogoutUsecase()
    
    private let withdrawalUsecase = WithdrawalUsecase()
    
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
            let logoutOuput = logoutUsecase.execute(.init())
                .withUnretained(self)
                .flatMap { owner, _ -> Observable<Mutation> in
                    DispatchQueue.main.async {
                        Router.shared.back(animated: false)
                        owner.notificationCenterManager.post(data: ())
                    }
                    return .empty()
                }
            
            DispatchQueue.main.async { [weak self] in
                Router.shared.back(animated: false)
                self?.notificationCenterManager.post(data: ())
            }
            
            return .empty()
            
        case .tapWithdrawRow:
            let withdrawalUsecase = withdrawalUsecase
                .execute(.init())
                .debug("::: usecase")
                .withUnretained(self)
                .flatMap { owner, output -> Observable<Mutation> in
                    if output.isSuccess {
                        owner.notificationCenterManager.post(data: ())
                    }
                    return .empty() // 성공적인 경우 반환할 Mutation 정의
                }
            
            return withdrawalUsecase
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
