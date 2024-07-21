//
//  AnnouncementReactor.swift
//  HomePresent
//
//  Created by DOYEON LEE on 7/17/24.
//

import ReactorKit

import AnnouncementUsecase
import AnnouncementEntity

class AnnouncementPageReactor: Reactor {

    enum Action {
        case viewWillAppear
    }
    
    enum Mutation {
        case setOrganizations([AnnouncementOrganizationEntity])
    }
    
    struct State {
        var organizations: [AnnouncementOrganizationEntity] = []
    }
    
    // MARK: Dependency
    let fetchAllAnnouncementUsecase = FetchAllAnnouncementUsecase()
    
    let initialState: State = State()
}

extension AnnouncementPageReactor {
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .viewWillAppear:
            return fetchAllAnnouncementUsecase.execute()
                .map { organizations in
                    return .setOrganizations(organizations)
                }
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
}
