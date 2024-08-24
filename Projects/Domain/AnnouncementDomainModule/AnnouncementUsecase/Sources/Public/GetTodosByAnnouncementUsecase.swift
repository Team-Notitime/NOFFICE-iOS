//
//  GetTodosByAnnouncementUsecase.swift
//  AnnouncementUsecase
//
//  Created by DOYEON LEE on 8/24/24.
//

import Foundation

import AnnouncementData
import AnnouncementDataInterface
import AnnouncementEntity
import Container

import RxSwift
import Swinject

public struct GetTodosByAnnouncementUsecase {
    // MARK: DTO
    public struct Input {
        let announcementId: Int64
        
        public init(announcementId: Int64) {
            self.announcementId = announcementId
        }
    }
    
    public struct Output { 
        public let todos: [AnnouncementTodoEntity]
    }
    
    // MARK: Error
    public enum Error: LocalizedError {
        case invalidResponseWithTasks
        
        public var errorDescription: String? {
            switch self {
            case .invalidResponseWithTasks:
                return "Response has no tasks"
            }
        }
    }
    
    // MARK: Dependency
    private let announcementRepository = Container.shared.resolve(AnnouncementRepositoryInterface.self)!
    
    // MARK: Initializer
    public init() { }
    
    // MARK: Execute method
    public func execute(_ input: Input) -> Observable<Output> {
        let outputObservable = announcementRepository
            .getTodosByAnnouncement(
                .init(announcementId: input.announcementId)
            )
            .map { response -> [AnnouncementTodoEntity] in
                guard let todos = response.tasks else {
                    throw Error.invalidResponseWithTasks
                }
                
                return todos.map { todo in
                    AnnouncementTodoEntity(
                        id: Int(todo.id ?? 0),
                        content: todo.content ?? "",
                        status: .pending
                    )
                }
            }
            .map { todoEntities in
                Output(todos: todoEntities)
            }
            .catch { error in
                return .error(error)
            }
        
        return outputObservable
    }
}
