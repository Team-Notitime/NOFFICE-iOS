//
//  EditTodoReactor.swift
//  NewAnnouncementPresent
//
//  Created by DOYEON LEE on 7/22/24.
//

import Foundation

import AnnouncementEntity

import ReactorKit

class EditTodoReactor: Reactor {
    // MARK: Action
    enum Action {
        case pressEnter
        case changeTodoContent(String)
        case deleteTodo(AnnouncementTodoEntity)
    }
    
    // MARK: Mutation
    enum Mutation {
        case addTodo
        case setTodoContent(String)
        case deleteTodo(AnnouncementTodoEntity)
    }
    
    // MARK: State
    struct State {
        var todoContent: String = ""
        var todos: [AnnouncementTodoEntity] = []
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
        case .pressEnter:
            return Observable.just(.addTodo)

        case let .changeTodoContent(content):
            return .just(.setTodoContent(content))
            
        case .deleteTodo(let todo):
            return Observable.just(.deleteTodo(todo))
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case .addTodo:
            let entity: AnnouncementTodoEntity = .init( // TODO: Add 용 Entity 분리해야겠다
                id: UUID().uuidString.hashValue,
                content: state.todoContent, 
                status: .pending
            )
            state.todos.append(entity)
            state.todoContent = ""
            
        case let .setTodoContent(content):
            state.todoContent = content
            
        case .deleteTodo(let todo):
            state.todos.removeAll { $0 == todo }
        }
        return state
    }
    
    // MARK: Child bind
    private func setupChildBind() { }
    
    // MARK: Transform
    
    // MARK: Private method
}
