//
//  GetTodosByOrganizationUsecase.swift
//  TodoUsecase
//
//  Created by DOYEON LEE on 8/23/24.
//

import Container
import Foundation
import RxSwift
import Swinject
import TodoData
import TodoDataInterface
import TodoEntity

public final class GetTodosByOrganizationUsecase {
    // MARK: DTO
    public struct Input {
        public init() {}
    }

    public struct Output {
        public let organization: [TodoOrganizationEntity]
    }

    // MARK: Error
    public enum Error: LocalizedError {
        case contentFieldNotFound
    }

    // MARK: Dependency
    private let todoRepository = Container.shared.resolve(TodoRepositoryInterface.self)!

    // MARK: Initializer
    public init() {}

    // MARK: Execute method
    public func execute(_: Input) -> Observable<Output> {
        let outputObservable = todoRepository
            .getAssignedTodos(.init())
            .map { response in
                guard let pagedContent = response.content else {
                     throw Error.contentFieldNotFound
                 }
                 
                 let organizations = pagedContent.map { organization in
                     let todos = organization.tasks?.map { task in
                         TodoItemEntity(
                             id: task.id ?? 0,
                             contents: task.content ?? "",
                             status: .pending // TODO: 판단 로직 필요
                         )
                     }
                     
                     return TodoOrganizationEntity(
                         id: organization.organizationId ?? 0,
                         name: organization.organizationName ?? "",
                         todos: todos ?? []
                     )
                 }
                 
                 return Output(organization: organizations)
            }
        
        return outputObservable
    }
}
