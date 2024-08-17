//
//  OrganizationDetailReactor.swift
//  OrganizationPresent
//
//  Created by DOYEON LEE on 7/31/24.
//

import AnnouncementUsecase
import AnnouncementEntity
import OrganizationUsecase
import OrganizationEntity

import ReactorKit

class OrganizationDetailReactor: Reactor {
    // MARK: Action
    enum Action { 
        case viewDidLoad(OrganizationEntity)
    }
    
    enum Mutation { 
        case setOrganization(OrganizationEntity)
        case setAnnouncements([AnnouncementEntity])
    }
    
    // MARK: State
    struct State { 
        var organization: OrganizationEntity?
        var announcements: [AnnouncementEntity] = []
    }
    
    let initialState: State = State()
    
    // MARK: ChildReactor
    
    // MARK: Dependency
    private let getOrganizationDetailUsecase = GetOrganizationDetailUsecase()
    
    private let getAnnouncementsByGroupUseCase = GetAnnouncementsByGroup()
    
    // MARK: DisposeBag
    private let disposeBag = DisposeBag()
    
    // MARK: Initializer
    init() { }
    
    // MARK: Action operation
    func mutate(action: Action) -> Observable<Mutation> {
        switch action { 
        case let .viewDidLoad(organization):
            let setOrganization = getOrganizationDetailUsecase
                .execute(.init(organizationId: organization.id))
                .map { Mutation.setOrganization($0.organization) }
            
            let setAnnouncements = getAnnouncementsByGroupUseCase
                .execute(groupId: organization.id)
                .delay(.seconds(2), scheduler: MainScheduler.instance)
                .map { Mutation.setAnnouncements($0) }
            
            return .merge(
                setOrganization,
                setAnnouncements
            )
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation { 
        case let .setOrganization(organization):
            state.organization = organization
            
        case let .setAnnouncements(announcements):
            state.announcements = announcements
        }
        return state
    }
    
    // MARK: Child bind
    private func setupChildBind() { }
    
    // MARK: Transform
    
    // MARK: Private method
}
