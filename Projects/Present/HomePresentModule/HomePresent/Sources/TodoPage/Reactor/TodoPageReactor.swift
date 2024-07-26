//
//  TodoPageReactor.swift
//  HomePresent
//
//  Created by DOYEON LEE on 7/21/24.
//

import ReactorKit

import TodoEntity

class TodoPageReactor: Reactor {
    // MARK: Action
    enum Action { 
        case viewWillAppear
        case tapTodoItem(TodoItemEntity)
    }
    
    enum Mutation { 
        case setOrganizations([TodoOrganizationEntity])
    }
    
    // MARK: State
    struct State { 
        var organizations: [TodoOrganizationEntity] = []
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
        case .viewWillAppear:
            var temp = TodoOrganizationEntity.mock
            temp = temp.map { organization in
                let newTodos = organization.todos.sorted { $0.status == .pending && $1.status == .done }
                return TodoOrganizationEntity(
                    id: organization.id,
                    name: organization.name,
                    todos: newTodos
                )
            }
            return .just(.setOrganizations(temp))
            
        case let .tapTodoItem(todo):
            var temp = TodoOrganizationEntity.mock
            temp = temp.map { organization in
                var newTodos = organization.todos.map { todoEntity -> TodoItemEntity in
                    if todoEntity.id == todo.id {
                        var updatedTodo = todoEntity
                        updatedTodo.status = todoEntity.status == .done ? .pending : .done
                        return updatedTodo
                    }
                    return todoEntity
                }
                newTodos.sort { $0.status == .pending && $1.status == .done }
                return TodoOrganizationEntity(
                    id: organization.id,
                    name: organization.name,
                    todos: newTodos
                )
            }
            return .just(.setOrganizations(temp))
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case let .setOrganizations(organizations):
            state.organizations = organizations
        }
        return state
    }
    
    // MARK: Child bind
    private func setupChildBind() { }
    
    // MARK: Transform
    
    // MARK: Private method
}
