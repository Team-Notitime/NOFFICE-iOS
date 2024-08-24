//
//  AnnouncementDetailReactor.swift
//  AnnouncementPresent
//
//  Created by DOYEON LEE on 7/26/24.
//

import AnnouncementEntity
import AnnouncementUsecase
import ReactorKit

class AnnouncementDetailReactor: Reactor {
    // MARK: Action
    enum Action {
        case viewWillAppear(AnnouncementSummaryEntity, AnnouncementOrganizationEntity)
        case toggleTodoStatus(AnnouncementTodoEntity)
    }
    
    enum Mutation {
        case setAnnouncementSummary(AnnouncementSummaryEntity)
        case setAnnouncement(AnnouncementEntity)
        case setOrganization(AnnouncementOrganizationEntity)
        case setTodoItems(Set<AnnouncementTodoEntity>)
        case updateTodoStatus(AnnouncementTodoEntity)
    }
    
    // MARK: State
    struct State {
        var announcementSummary: AnnouncementSummaryEntity?
        var announcement: AnnouncementEntity?
        var organization: AnnouncementOrganizationEntity?
        var todoItems: Set<AnnouncementTodoEntity>?
    }
    
    let initialState: State = .init()
    
    // MARK: Dependency
    private let fetchAnnouncementDetailUsecase = GetAnnouncementDetailUsecase()
    
    private let getTodosByAnnouncementUsecase = GetTodosByAnnouncementUsecase()
    
    // MARK: DisposeBag
    private let disposeBag = DisposeBag()
    
    // MARK: Initializer
    init() {}
    
    // MARK: Action operation
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case let .viewWillAppear(
            announcementSummary,
            organization
        ):
            let detailObservable = fetchAnnouncementDetailUsecase
                .execute(.init(announcementId: announcementSummary.id))

            let todosObservable = getTodosByAnnouncementUsecase
                .execute(.init(announcementId: announcementSummary.id))
                .map { output in
                    Mutation.setTodoItems(Set(output.todos))
                }

            return .merge(
                .just(Mutation.setOrganization(organization)),
                .just(Mutation.setAnnouncementSummary(announcementSummary)),
                detailObservable
                    .delay(.seconds(1), scheduler: MainScheduler.instance)
                    .map { output in
                        Mutation.setAnnouncement(output.announcement)
                    },
                todosObservable
            )

        case let .toggleTodoStatus(todo):
            let newTodo = todo.copy(
                with: \.status,
                value: todo.status == .done ? .pending : .done
            )

            return .just(.updateTodoStatus(newTodo))
        }
    }

    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case let .setAnnouncementSummary(announcement):
            state.announcementSummary = announcement
            
        case let .setAnnouncement(announcement):
            state.announcement = announcement
            
        case let .setTodoItems(todos):
            state.todoItems = todos
            
        case let .updateTodoStatus(newTodo):
            state.todoItems?.remove(newTodo)
            state.todoItems?.insert(newTodo)
            
        case let .setOrganization(organization):
            state.organization = organization
        }
        return state
    }
}
