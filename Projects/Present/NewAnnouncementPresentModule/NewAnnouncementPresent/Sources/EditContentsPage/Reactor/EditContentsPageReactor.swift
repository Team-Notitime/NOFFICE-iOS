//
//  EditContentsPageReactor.swift
//  NewAnnouncementPresent
//
//  Created by DOYEON LEE on 7/22/24.
//

import Foundation

import ReactorKit

class EditContentsPageReactor: Reactor {
    // MARK: Action
    enum Action { 
        case tapCompleteButton
    }
    
    enum Mutation { }
    
    // MARK: State
    struct State { }
    
    let initialState: State = State()
    
    // MARK: ChildReactor
    
    // MARK: Dependency
    
    // MARK: DisposeBag
    private let disposeBag = DisposeBag()
    
    // MARK: Initializer
    init() { }
    
    // MARK: Action operation
    func mutate(action: Action) -> Observable<Mutation> {
        switch action { 
        case .tapCompleteButton:
            // pass to parent
            return .empty()
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation { }
        return state
    }
    
    // MARK: Child bind
    private func setupChildBind() { }
    
    // MARK: Transform
    
    // MARK: Private method
}
