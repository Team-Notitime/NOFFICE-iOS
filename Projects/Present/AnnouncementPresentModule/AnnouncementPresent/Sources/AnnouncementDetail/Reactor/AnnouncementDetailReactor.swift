//
//  AnnouncementDetailReactor.swift
//  AnnouncementPresent
//
//  Created by DOYEON LEE on 7/26/24.
//

import AnnouncementUsecase
import AnnouncementEntity

import ReactorKit

class AnnouncementDetailReactor: Reactor {
    // MARK: Action
    enum Action { 
        case viewDidLoad
    }
    
    enum Mutation { 
        case setAnnouncementItem(AnnouncementItemEntity)
    }
    
    // MARK: State
    struct State { 
        var announcementItem: AnnouncementItemEntity?
    }
    
    let initialState: State = State()
    // MARK: Dependency
    private let fetchAnnouncementDetailUsecase = FetchAnnouncementDetailUsecase()
    
    // MARK: DisposeBag
    private let disposeBag = DisposeBag()
    
    // MARK: Initializer
    init() { }
    
    // MARK: Action operation
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .viewDidLoad:
            let detailObserver = fetchAnnouncementDetailUsecase.execute()
            
            return detailObserver
                .map { Mutation.setAnnouncementItem($0) }
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation { 
        case let .setAnnouncementItem(item):
            state.announcementItem = item
        }
        return state
    }
}
