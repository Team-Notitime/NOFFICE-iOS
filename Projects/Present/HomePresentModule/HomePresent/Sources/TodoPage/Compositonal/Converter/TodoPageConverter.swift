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
        onTodoItemTap: @escaping (TodoItemEntity) -> Bool
    ) -> [any CompositionalSection] {
        return entities.map { organizationEntity in
            TodoSection(
                organizationId: organizationEntity.id,
                organizationName: organizationEntity.name,
                items: organizationEntity.todos.map { todoEntity in
                    TodoItem(
                        id: todoEntity.id,
                        contents: todoEntity.contents,
                        onTap: {
                            return onTodoItemTap(todoEntity)
                        }
                    )
                }
            )
        }
    }
}
