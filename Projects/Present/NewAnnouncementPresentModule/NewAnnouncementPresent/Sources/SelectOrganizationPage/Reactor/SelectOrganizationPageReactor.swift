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
        case changeSelectedOrganization(OrganizationEntity)
    }
    
    enum Mutation { 
        case setMyOrganizations([OrganizationEntity])
        case setSelectedOrganization(OrganizationEntity)
        case changeNextButtonActive(Bool)
    }
    
    // MARK: State
    struct State { 
        var myOrganizations: [OrganizationEntity] = []
        var selectedOrganization: OrganizationEntity?
        var nextButtonActive: Bool = false
    }
    
    let initialState: State = State()

    // MARK: Dependency
    private let fetchMyOrganizations = GetMyOrganizationsUsecase()
    
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
        case let .changeSelectedOrganization(organization):
            return .merge(
                .just(Mutation.setSelectedOrganization(organization)),
                .just(Mutation.changeNextButtonActive(true))
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
