//
//  AnnouncementReactor.swift
//  HomePresent
//
//  Created by DOYEON LEE on 7/17/24.
//

import ReactorKit

class AnnouncementPageReactor: Reactor {

    enum Action {
        case viewWillAppear
    }
    
    enum Mutation {
        
    }
    
    struct State {
        
    }
    
    let initialState: State = State()
}

extension AnnouncementPageReactor {
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .viewWillAppear:

            return Observable.merge([])
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        }
    }
}
