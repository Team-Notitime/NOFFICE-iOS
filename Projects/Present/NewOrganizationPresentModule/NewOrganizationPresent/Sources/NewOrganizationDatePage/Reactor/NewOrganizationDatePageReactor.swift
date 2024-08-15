//
//  NewOrganizationEndDatePageReactor.swift
//  OrganizationPresent
//
//  Created by DOYEON LEE on 7/19/24.
//

import Foundation

import OrganizationEntity

import ReactorKit

class NewOrganizationDatePageReactor: Reactor {
    // MARK: Action
    enum Action {
        case changeSelectedDate(Date?)
        case tapNextPageButton
    }
    
    enum Mutation {
        case setSelectedDate(Date?)
    }
    
    // MARK: State
    struct State {
        var selectedDate: Date?
        var nextPageButtonActive: Bool = false
    }
    
    let initialState: State = State()
    
    // MARK: DisposeBag
    private let disposeBag = DisposeBag()
    
    // MARK: Initializer
    init() { }
    
    // MARK: Action operation
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case let .changeSelectedDate(date):
            return .just(.setSelectedDate(date))
            
        case .tapNextPageButton:
            // pass to parent
            return .empty()
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case let .setSelectedDate(date):
            state.selectedDate = date
            state.nextPageButtonActive = date != nil
        }
        return state
    }
}
