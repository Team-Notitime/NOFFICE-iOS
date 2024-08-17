//
//  OrganizationTabReactor.swift
//  OrganizationPresent
//
//  Created by DOYEON LEE on 7/31/24.
//

import OrganizationUsecase
import OrganizationEntity

import ReactorKit

class OrganizationTabReactor: Reactor {
    // MARK: Action
    enum Action { 
        case viewDidLoad
    }
    
    enum Mutation { 
        case setOrganizations([OrganizationEntity])
    }
    
    // MARK: State
    struct State { 
        var organizations: [OrganizationEntity] = []
    }
    
    let initialState: State = State()
    
    // MARK: ChildReactor
    
    // MARK: Dependency
    private let getMyOrganizationsUsecase = GetMyOrganizationsUsecase()
    
    // MARK: DisposeBag
    private let disposeBag = DisposeBag()
    
    // MARK: Initializer
    init() { }
    
    // MARK: Action operation
    func mutate(action: Action) -> Observable<Mutation> {
        switch action { 
        case .viewDidLoad:
            return getMyOrganizationsUsecase.execute(.init())
                .debug()
                .map { Mutation.setOrganizations($0.organizations) }
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation { 
        case let .setOrganizations(organizations):
            print("와웅")
            state.organizations = organizations
        }
        return state
    }
    
    // MARK: Child bind
    private func setupChildBind() { }
    
    // MARK: Transform
    
    // MARK: Private method
}
