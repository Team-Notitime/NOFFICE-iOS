//
//  SelectOrganizationPageReactor.swift
//  NewAnnouncementPresent
//
//  Created by DOYEON LEE on 7/22/24.
//

import Foundation

import OrganizationUsecase
import OrganizationEntity

import ReactorKit

class SelectOrganizationPageReactor: Reactor {
    // MARK: Action
    enum Action { 
        case viewDidLoad
        case tapNextPageButton
    }
    
    enum Mutation { 
        case setMyOrganizations([OrganizationEntity])
    }
    
    // MARK: State
    struct State { 
        var myOrganizations: [OrganizationEntity] = []
    }
    
    let initialState: State = State()
    
    // MARK: ChildReactor
    
    // MARK: Dependency
    private let fetchMyOrganizations = FetchMyOrganizations()
    
    // MARK: DisposeBag
    private let disposeBag = DisposeBag()
    
    // MARK: Initializer
    init() { }
    
    // MARK: Action operation
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .viewDidLoad:
            return fetchMyOrganizations.execute()
                .map { organizations in
                    return .setMyOrganizations(organizations)
                }
        case .tapNextPageButton:
            // pass to parent
            return .empty()
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation { 
        case let .setMyOrganizations(organizations):
            state.myOrganizations = organizations
        }
        return state
    }
    
    // MARK: Child bind
    private func setupChildBind() { }
    
    // MARK: Transform
    
    // MARK: Private method
}
