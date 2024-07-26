//
//  EditNotificationReactor.swift
//  NewAnnouncementPresent
//
//  Created by DOYEON LEE on 7/22/24.
//

import ReactorKit

import AnnouncementEntity

class EditNotificationReactor: Reactor {
    // MARK: Action
    enum Action {
        case selectReminder(AnnouncementRemindNotification)
        case deselectReminder(AnnouncementRemindNotification)
    }
    
    enum Mutation {
        case addSelectReminder(AnnouncementRemindNotification)
        case removeSelectReminder(AnnouncementRemindNotification)
    }
    
    // MARK: State
    struct State { 
        var selectedTimeOptions: Set<AnnouncementRemindNotification> = []
        var timeOptions: [AnnouncementRemindNotification] = AnnouncementRemindNotification
            .defaultBefore
    }
    
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
        case .selectReminder(let notification):
            return .just(.addSelectReminder(notification))
            
        case .deselectReminder(let notification):
            return .just(.removeSelectReminder(notification))
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case .addSelectReminder(let notification):
            state.selectedTimeOptions.insert(notification)
            
        case .removeSelectReminder(let notification):
            state.selectedTimeOptions.remove(notification)
        }
        return state
    }
    
    // MARK: Child bind
    private func setupChildBind() { }
    
    // MARK: Transform
    
    // MARK: Private method
}
