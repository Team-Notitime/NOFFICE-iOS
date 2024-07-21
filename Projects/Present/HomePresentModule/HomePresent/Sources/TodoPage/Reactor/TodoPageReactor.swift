//
//  TodoPageReactor.swift
//  HomePresent
//
//  Created by DOYEON LEE on 7/21/24.
//

import ReactorKit

import TodoEntity

class TodoPageReactor: Reactor {
    // MARK: Action
    enum Action { 
        case viewWillAppear
    }
    
    enum Mutation { 
        case setOrganizations([TodoOrganizationEntity])
    }
    
    // MARK: State
    struct State { 
        var organizations: [TodoOrganizationEntity] = []
    }
    
    let initialState: State = State()
    
    // MARK: ChildReactor
    
    // MARK: Dependency
    
    // MARK: DisposeBag
    private let disposeBag = DisposeBag()
    
    // MARK: Initializer
    init() { }
    
    // MARK: Action operation
    func mutate(action: Action) -> Observable<Mutation> {
        switch action { 
        case .viewWillAppear:
            let temp = TodoOrganizationEntity.mock
            return .just(.setOrganizations(temp))
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case let .setOrganizations(organizations):
            state.organizations = organizations
        }
        return state
    }
    
    // MARK: Child bind
    private func setupChildBind() { }
    
    // MARK: Transform
    
    // MARK: Private method
}
