//
//  EditTodoConverter.swift
//  NewAnnouncementPresent
//
//  Created by DOYEON LEE on 7/25/24.
//

import AnnouncementEntity

struct EditTodoConverter {
    static func convertToTodoSections(
        todos: [AnnouncementTodoEntity],
        action: @escaping (AnnouncementTodoEntity) -> Void
    ) -> [TodoSection] {
        return todos.enumerated().map { index, todo in
            TodoSection(
                todoId: index,
                items: [
                    TodoItem(content: todo.content),
                    TodoDeleteItem(
                        id: index + 1000,
                        content: todo.content
                    ) {
                        action(todo)
                    }
                ]
            )
        }
    }
}
