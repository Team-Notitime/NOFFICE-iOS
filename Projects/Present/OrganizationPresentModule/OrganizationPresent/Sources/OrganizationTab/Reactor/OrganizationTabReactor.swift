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
        case viewWillAppear
    }
    
    enum Mutation { 
        case setOrganizations([OrganizationSummaryEntity])
    }
    
    // MARK: State
    struct State { 
        var organizations: [OrganizationSummaryEntity] = []
    }
    
    let initialState: State = State()
    
    // MARK: ChildReactor
    
    // MARK: Dependency
    private var getJoinedOrganizationsUsecase = GetJoinedOrganizationsUsecase()
    
    // MARK: DisposeBag
    private let disposeBag = DisposeBag()
    
    // MARK: Initializer
    init() { }
    
    // MARK: Action operation
    func mutate(action: Action) -> Observable<Mutation> {
        switch action { 
        case .viewWillAppear:
            getJoinedOrganizationsUsecase = GetJoinedOrganizationsUsecase() // 페이징 초기화 위해 새로 할당
            return getJoinedOrganizationsUsecase.execute(.init())
                .map { Mutation.setOrganizations($0.organizations) }
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
