//
//  NewOrganizationCompletePageReactor.swift
//  OrganizationPresent
//
//  Created by DOYEON LEE on 7/20/24.
//

import Foundation

import ReactorKit

class NewOrganizationCompletePageReactor: Reactor {
    // MARK: Action
    enum Action { 
        case tapGoHomeButton
        case tapCopyLinkButton
    }
    
    enum Mutation { }
    
    // MARK: State
    struct State { 
        var link: String = "https://www.link.com"
    }
    
    let initialState: State = State()
    
    // MARK: Initializer
    init() { }
    
    // MARK: Action operation
    func mutate(action: Action) -> Observable<Mutation> {
        switch action { 
        case .tapGoHomeButton:
            // pass to parent
            return .empty()
        case .tapCopyLinkButton:
            return .empty()
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation { }
        return state
    }
}
