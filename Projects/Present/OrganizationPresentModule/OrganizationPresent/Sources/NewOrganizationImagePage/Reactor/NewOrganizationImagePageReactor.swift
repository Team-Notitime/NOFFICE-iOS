//
//  NewOrganizationImagePageReactor.swift
//  OrganizationPresent
//
//  Created by DOYEON LEE on 7/19/24.
//

import OrganizationEntity

import ReactorKit

class NewOrganizationImagePageReactor: Reactor {
    // MARK: Action
    enum Action {
        case changeSelectedCateogries([OrganizationCategoryEntity])
        case tapNextPageButton
    }
    
    enum Mutation {
        case setSelectedCateogries([OrganizationCategoryEntity])
    }
    
    // MARK: State
    struct State {
        var selectedCateogries: [OrganizationCategoryEntity] = []
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
        case let .changeSelectedCateogries(categories):
            return .just(.setSelectedCateogries(categories))
            
        case .tapNextPageButton:
            // pass to parent
            return .empty()
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case let .setSelectedCateogries(categories):
            state.selectedCateogries = categories
            state.nextPageButtonActive = !categories.isEmpty
        }
        return state
    }
}
