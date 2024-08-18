//
//  AnnouncementReactor.swift
//  HomePresent
//
//  Created by DOYEON LEE on 7/17/24.
//

import ReactorKit

import AnnouncementUsecase
import AnnouncementEntity
import MemberUsecase
import MemberEntity

class AnnouncementPageReactor: Reactor {

    enum Action {
        case viewWillAppear
    }
    
    enum Mutation {
        case setOrganizations([AnnouncementOrganizationEntity])
        case setMember(MemberEntity)
    }
    
    struct State {
        var organizations: [AnnouncementOrganizationEntity] = []
        var member: MemberEntity?
    }
    
    // MARK: Dependency
    let fetchAllAnnouncementUsecase = GetAllAnnouncementUsecase()
    
    let getMemberUsecase = GetMemberUsecase()
    
    let initialState: State = State()
}

extension AnnouncementPageReactor {
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .viewWillAppear:
            let memberObservable = getMemberUsecase
                .execute(.init())
                .map { output in
                    return Mutation.setMember(output.member)
                }
            
            let announcementObservable = fetchAllAnnouncementUsecase
                .execute(.init())
                .debug(":::")
                .map { output in
                    return Mutation.setOrganizations(output.announcements)
                }
            
            return .merge( // concat은 왜 안되지?
                memberObservable,
                announcementObservable
            )
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case let .setOrganizations(organizations):
            state.organizations = organizations
        case let .setMember(member):
            state.member = member
        }
        return state
    }
}
