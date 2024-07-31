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
        onLongPress: @escaping (AnnouncementTodoEntity) -> Void
    ) -> [TodoSection] {
        return todos.enumerated().map { index, todo in
            TodoSection(
                todoId: index,
                items: [
                    TodoItem(content: todo.content) {
                        onLongPress(todo)
                    }
                ]
            )
        }
    }
}
