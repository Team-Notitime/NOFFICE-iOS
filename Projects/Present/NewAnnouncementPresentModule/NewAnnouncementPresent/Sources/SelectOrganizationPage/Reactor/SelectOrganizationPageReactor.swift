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
        case changeSelectedOrganization(OrganizationSummaryEntity?)
    }
    
    enum Mutation { 
        case setMyOrganizations([OrganizationSummaryEntity])
        case setSelectedOrganization(OrganizationSummaryEntity?)
        case changeNextButtonActive(Bool)
    }
    
    // MARK: State
    struct State { 
        var myOrganizations: [OrganizationSummaryEntity] = []
        var selectedOrganization: OrganizationSummaryEntity?
        var nextButtonActive: Bool = false
    }
    
    let initialState: State = State()

    // MARK: Dependency
    private let fetchMyOrganizations = GetJoinedOrganizationsUsecase()
    
    // MARK: DisposeBag
    private let disposeBag = DisposeBag()
    
    // MARK: Initializer
    init() { }
    
    // MARK: Action operation
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .viewDidLoad:
            return fetchMyOrganizations.execute(.init())
                .map { ouput in
                    return .setMyOrganizations(ouput.organizations)
                }
        case let .changeSelectedOrganization(selectedOrganization):
            return .merge(
                .just(Mutation.setSelectedOrganization(selectedOrganization)),
                .just(Mutation.changeNextButtonActive(selectedOrganization != nil))
            )
            
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
            
        case let .setSelectedOrganization(organization):
            state.selectedOrganization = organization
            
        case let .changeNextButtonActive(active):
            state.nextButtonActive = active
        }
        return state
    }
}
