//
//  EditDateTimeReactor.swift
//  NewAnnouncementPresent
//
//  Created by DOYEON LEE on 7/22/24.
//

import Foundation

import ReactorKit

class EditDateTimeReactor: Reactor {
    // MARK: Action
    enum Action {
        case changeSelectedDate(Date)
        case changeSelectedTime(DateComponents)
        case reset
    }

    enum Mutation {
        case setSelectedDate(Date?)
        case setSelectedTime(DateComponents?)
    }

    // MARK: State
    struct State {
        var selectedDate: Date?
        var selectedTime: DateComponents?
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
        case let .changeSelectedDate(date):
            return .just(.setSelectedDate(date))
            
        case let .changeSelectedTime(time):
            return .just(.setSelectedTime(time))
            
        case .reset:
            return .merge(
                .just(.setSelectedDate(nil)),
                .just(.setSelectedTime(nil))
            )
        }
    }

    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case let .setSelectedDate(date):
            state.selectedDate = date
            
        case let .setSelectedTime(time):
            state.selectedTime = time
        }
        return state
    }

    // MARK: Child bind
    private func setupChildBind() { }

    // MARK: Transform

    // MARK: Private method
}
