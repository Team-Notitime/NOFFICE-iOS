//
//  OrganizationDetailReactor.swift
//  OrganizationPresent
//
//  Created by DOYEON LEE on 7/31/24.
//

import OrganizationEntity

import ReactorKit

class OrganizationDetailReactor: Reactor {
    // MARK: Action
    enum Action { 
        case viewDidLoad(OrganizationEntity)
    }
    
    enum Mutation { 
        case setOrganization(OrganizationEntity)
    }
    
    // MARK: State
    struct State { 
        var organization: OrganizationEntity?
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
        case let .viewDidLoad(organization):
            return .just(.setOrganization(organization))
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation { 
        case let .setOrganization(organization):
            state.organization = organization
            
        }
        return state
    }
    
    // MARK: Child bind
    private func setupChildBind() { }
    
    // MARK: Transform
    
    // MARK: Private method
}
