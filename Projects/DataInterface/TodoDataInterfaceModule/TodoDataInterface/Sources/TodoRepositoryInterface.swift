//
//  TodoDataInterface.swift
//  TodoDataInterface
//
//  Created by DOYEON LEE on 8/15/24.
//

import RxSwift

/// A repository that handles network communication with the server related to the organization domain.
public protocol TodoRepositoryInterface {
    func getAssignedTodos(
        _ request: GetAssignedTodosRequest
    ) -> Observable<GetAssignedTodosResponse>
    
    func updateTodo(
        _ request: UpdateTodoRequest
    ) -> Observable<UpdateTodoResponse>
}
