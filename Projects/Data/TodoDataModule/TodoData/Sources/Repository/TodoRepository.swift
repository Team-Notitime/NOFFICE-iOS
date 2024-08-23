//
//  TodoRepository.swift
//  TodoData
//
//  Created by DOYEON LEE on 8/15/24.
//

import CommonData
import Foundation
import OpenapiGenerated
import OpenAPIURLSession
import RxSwift
import TodoDataInterface

/// A repository that handles network communication with the server related to the organization domain.
public struct TodoRepository: TodoRepositoryInterface {
    private let client: APIProtocol
    
    public init() {
        self.client = Client(
            serverURL: UrlConfig.baseUrl.url,
            configuration: .init(
                dateTranscoder: .custom
            ),
            transport: URLSessionTransport(),
            middlewares: [AuthenticationMiddleware()]
        )
    }
    

    public func getAssignedTodos(
        _ request: GetAssignedTodosRequest
    ) async throws -> Observable<GetAssignedTodosResponse> {
        return Observable.create { observer in
            Task {
                do {
                    let response = try await client.getAssigned(
                        .init(
                            query: .init(
                                pageable: request
                            )
                        )
                    )
                    
                    if let data = try response.ok.body.json.data {
                        observer.onNext(data)
                        observer.onCompleted()
                    } else {
                        observer.onError(TodoError.invalidResponse)
                    }
                } catch {
                    observer.onError(TodoError.underlying(error))
                }
            }
            
            return Disposables.create()
        }
    }
    

    public func updateTodo(_ request: UpdateTodoRequest) async throws -> Observable<UpdateTodoResponse>{
        return Observable.create { observer in
            Task {
                do {
                    let response = try await client.modify(
                        .init(
                            query: .init(
                                taskModifyRequest: request
                            )
                        )
                    )
                    
                    if let data = try response.ok.body.json.data {
                        observer.onNext(data)
                        observer.onCompleted()
                    } else {
                        observer.onError(TodoError.invalidResponse)
                    }
                } catch {
                    observer.onError(TodoError.underlying(error))
                }
            }
            
            return Disposables.create()
        }
    }
}
