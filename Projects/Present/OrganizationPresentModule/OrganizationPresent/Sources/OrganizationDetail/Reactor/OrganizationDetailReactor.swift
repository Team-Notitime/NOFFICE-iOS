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
        case setAnnouncements([AnnouncementSummaryEntity])
    }
    
    // MARK: State
    struct State { 
        var organization: OrganizationEntity?
        var announcements: [AnnouncementSummaryEntity] = []
    }
    
    let initialState: State = State()
    
    // MARK: ChildReactor
    
    // MARK: Dependency
    private let getOrganizationDetailUsecase = GetOrganizationDetailUsecase()
    
    private let getAnnouncementsByGroupUseCase = GetAnnouncementsByOrganizationUsecase()
    
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
                .map { output in
                    Mutation.setOrganization(output.organization)
                }
            
            let setAnnouncements = getAnnouncementsByGroupUseCase
                .execute(.init(organizationId: Int64(organization.id)))
                .map { output in
                    Mutation.setAnnouncements(output.announcements)
                }
            
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
