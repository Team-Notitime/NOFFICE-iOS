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
        case toggleisOpenHasLeaderRoleOrganizationDialog
    }
    
    struct State {
        // - Data
        var organizations: [AnnouncementOrganizationEntity] = []
        var member: MemberEntity?
        
        // - View TODO: ㅠㅠ 어떻게하지 변수명 머선일
        var isOpenHasLeaderRoleOrganizationDialog: Bool = false
    }
    
    // MARK: Dependency
    var fetchAllAnnouncementUsecase = GetAllAnnouncementUsecase()
    
    let getMemberUsecase = GetMemberUsecase()
    
    let initialState: State = State()
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .viewWillAppear:
            let memberObservable = getMemberUsecase
                .execute(.init())
                .map { output in
                    return Mutation.setMember(output.member)
                }
            
            fetchAllAnnouncementUsecase = GetAllAnnouncementUsecase()
            let announcementObservable = fetchAllAnnouncementUsecase
                .execute(.init())
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
            
        case .toggleisOpenHasLeaderRoleOrganizationDialog:
            state.isOpenHasLeaderRoleOrganizationDialog
        }
        return state
    }
}
