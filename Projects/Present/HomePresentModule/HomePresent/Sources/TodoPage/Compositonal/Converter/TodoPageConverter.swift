//
//  TodoPageConverter.swift
//  HomePresent
//
//  Created by DOYEON LEE on 7/26/24.
//

import DesignSystem
import TodoEntity

struct TodoPageConverter {
    static func convertToTodoSections(
        _ entities: [TodoOrganizationEntity],
        onTodoItemTap: @escaping (TodoItemEntity) -> Void
    ) -> [any CompositionalSection] {
        return entities.map { organizationEntity in
            TodoSection(
                organizationId: organizationEntity.id,
                organizationName: organizationEntity.name,
                items: organizationEntity.todos.map { todoEntity in
                    TodoItem(
                        id: todoEntity.id,
                        status: todoEntity.status,
                        contents: todoEntity.contents,
                        onTap: {
                            onTodoItemTap(todoEntity)
                        }
                    )
                }
            )
        }
    }
}
