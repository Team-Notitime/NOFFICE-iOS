//
//  AnnouncementDetailConverter.swift
//  AnnouncementPresent
//
//  Created by DOYEON LEE on 7/26/24.
//

import DesignSystem
import AnnouncementEntity

struct AnnouncementDetailConverter {
    static func convertToTodoSections(
        todos: [AnnouncementTodoEntity],
        onTapTodoItem: @escaping (AnnouncementTodoEntity) -> Void
    ) -> [any CompositionalSection] {
        return [
            TodoSection(
                items: todos.map { todo in
                    TodoItem(
                        id: todo.id,
                        contents: todo.content,
                        status: todo.status == .done ? .done : .pending,
                        onTap: {
                            onTapTodoItem(todo)
                        }
                    )
                }
            )
        ]
    }
}
