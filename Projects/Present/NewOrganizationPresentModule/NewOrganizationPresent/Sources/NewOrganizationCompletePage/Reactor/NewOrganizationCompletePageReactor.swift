//
//  NewOrganizationCompletePageReactor.swift
//  OrganizationPresent
//
//  Created by DOYEON LEE on 7/20/24.
//

import Foundation

import ReactorKit
import MainEntity
import UIKit

class NewOrganizationCompletePageReactor: Reactor {
    // MARK: Action
    enum Action {
        case setNewOrganization(OrganizationEntity)
        case tapGoHomeButton
        case tapCopyLinkButton
    }
    
    enum Mutation {
      case setNewOrganization(OrganizationEntity)
    }
    
    // MARK: State
    struct State {
      var organization: OrganizationEntity?
      
      public init(
        organization: OrganizationEntity? = nil
      ) {
        self.organization = organization
      }
    }
    
    public var initialState: State = State(organization: nil)
    
    // MARK: Initializer
    public init() { }
  
    public convenience init(state: State) {
      self.init()
      self.initialState = state
    }
    
    // MARK: Action operation
    func mutate(action: Action) -> Observable<Mutation> {
        switch action { 
        case .tapGoHomeButton:
            // pass to parent
            return .empty()
        case .tapCopyLinkButton:
          if let id = currentState.organization?.id {
            UIPasteboard.general.string = "\(id)"
          }
            return .empty()
        case let .setNewOrganization(organizationEntity):
            return .just(.setNewOrganization(organizationEntity))
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case let .setNewOrganization(org):
            state.organization = org
        }
        return state
    }
}
