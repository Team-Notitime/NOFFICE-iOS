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
        case viewDidLoad(AnnouncementItemEntity)
        case toggleTodoStatus(AnnouncementTodoEntity)
    }
    
    enum Mutation { 
        case setAnnouncementItem(AnnouncementItemEntity)
        case setTodoItems(Set<AnnouncementTodoEntity>)
        case updateTodoStatus(AnnouncementTodoEntity)
    }
    
    // MARK: State
    struct State { 
        var announcementItem: AnnouncementItemEntity?
        var todoItems: Set<AnnouncementTodoEntity>?
    }
    
    let initialState: State = State()
    
    // MARK: Dependency
    private let fetchAnnouncementDetailUsecase = GetAnnouncementDetailUsecase()
    
    // MARK: DisposeBag
    private let disposeBag = DisposeBag()
    
    // MARK: Initializer
    init() { }
    
    // MARK: Action operation
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case let .viewDidLoad(announcement):
//            let detailObserver = fetchAnnouncementDetailUsecase.execute()
            let detailObserver = Observable<AnnouncementItemEntity>.create { observer in
                observer.onNext(announcement)
                
                return Disposables.create()
            }
            
            return .merge(
                detailObserver
                    .map { Mutation.setAnnouncementItem($0) },
                detailObserver
                    .compactMap { $0.todos }
                    .map { Mutation.setTodoItems(Set($0)) }
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
        case let .setAnnouncementItem(announcement):
            state.announcementItem = announcement
            
        case let .setTodoItems(todos):
            state.todoItems = todos
            
        case let .updateTodoStatus(newTodo):
            state.todoItems?.remove(newTodo)
            state.todoItems?.insert(newTodo)
        }
        return state
    }
}
