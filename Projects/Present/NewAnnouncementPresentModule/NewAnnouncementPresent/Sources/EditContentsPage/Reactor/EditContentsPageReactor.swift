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
        case changeDateTimeActive(Bool)
        case changeLocationActive(Bool)
        case changeTodoActive(Bool)
        case changeNotificationActive(Bool)
    }

    enum Mutation {
        case setDateTimeActive(Bool)
        case setLocationActive(Bool)
        case setTodoActive(Bool)
        case setNotificationActive(Bool)
    }

    // MARK: State
    struct State {
        var dateActive: Bool = false
        var locationActive: Bool = false
        var todoActive: Bool = false
        var notificationActive: Bool = false
    }

    let initialState: State = State()

    // MARK: ChildReactor

    private let editDateTimeReactor: EditDateTimeReactor
    private let editLocationReactor: EditLocationReactor
    private let editTodoReactor: EditTodoReactor
    private let editNotificationReactor: EditNotificationReactor

    // MARK: Dependency

    // MARK: DisposeBag
    private let disposeBag = DisposeBag()

    // MARK: Initializer
    init(
        editDateTimeReactor: EditDateTimeReactor,
        editLocationReactor: EditLocationReactor,
        editTodoReactor: EditTodoReactor,
        editNotificationReactor: EditNotificationReactor
    ) {
        self.editDateTimeReactor = editDateTimeReactor
        self.editLocationReactor = editLocationReactor
        self.editTodoReactor = editTodoReactor
        self.editNotificationReactor = editNotificationReactor

        setupChildBind()
    }

    // MARK: Action operation
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .tapCompleteButton:
            // pass to parent
            return .empty()
            
        case let .changeDateTimeActive(isActive):
            return .just(.setDateTimeActive(isActive))

        case let .changeLocationActive(isActive):
            return .just(.setLocationActive(isActive))

        case let .changeTodoActive(isActive):
            return .just(.setTodoActive(isActive))

        case let .changeNotificationActive(isActive):
            return .just(.setNotificationActive(isActive))
        }
    }

    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case let .setDateTimeActive(isActive):
            state.dateActive = isActive
            
        case let .setLocationActive(isActive):
            state.locationActive = isActive
            
        case let .setTodoActive(isActive):
            state.todoActive = isActive
            
        case let .setNotificationActive(isActive):
            state.notificationActive = isActive
        }
        return state
    }

    // MARK: Child bind
    private func setupChildBind() {
//        editDateTimeReactor.state
//            .map { $0.dateTime != nil } // Assuming dateTime is an optional property in the state
//            .map
//            .bind(to: self.action)
//            .disposed(by: disposeBag)

        editLocationReactor.state
            .map { !$0.locationName.isEmpty || !$0.locationLink.isEmpty }
            .map { .changeLocationActive($0) }
            .bind(to: self.action)
            .disposed(by: disposeBag)

        editTodoReactor.state
            .map { !$0.todos.isEmpty } // Assuming todoItems is a collection property in the state
            .map { .changeTodoActive($0) }
            .bind(to: self.action)
            .disposed(by: disposeBag)

        editNotificationReactor.state
            .map { !$0.selectedTimeOptions.isEmpty } // Assuming selectedTimeOptions is a collection property in the state
            .map { .changeNotificationActive($0) }
            .bind(to: self.action)
            .disposed(by: disposeBag)
    }
    
    // MARK: Transform
    
    // MARK: Private method
}
