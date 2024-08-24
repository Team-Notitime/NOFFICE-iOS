//
//  TodoOrganizationEntity.swift
//  TodoEntity
//
//  Created by DOYEON LEE on 7/21/24.
//

import Foundation

/**
 Represents an organization containing a list of todos.
*/
public struct TodoOrganizationEntity: Codable, Identifiable, Equatable {
    /// Unique identifier for the organization.
    public let id: Int64
    
    /// Name of the organization in Korean.
    public let name: String
    
    /// List of todos associated with the organization.
    public let todos: [TodoItemEntity]
    
    public init(
        id: Int64,
        name: String,
        todos: [TodoItemEntity]
    ) {
        self.id = id
        self.name = name
        self.todos = todos
    }
    
    // MARK: - Mock
    public static let mock = [
        TodoOrganizationEntity(
            id: 1,
            name: "CMC 15th",
            todos: [
                .init(id: 1, contents: "팀원 리스트 제출", status: .done),
                .init(id: 2, contents: "기획 발표 자료 제출", status: .pending)
            ]
        ),
        TodoOrganizationEntity(
            id: 2,
            name: "즐거운 동아리",
            todos: [
                .init(id: 3, contents: "4차 세션 사전 과제", status: .pending),
                .init(id: 4, contents: "노션 이메일 제출", status: .pending),
                .init(id: 5, contents: "뒷풀이 참석 여부 투표 뒷풀이 참석 여부 투표 뒷풀이 참석 여부 투표 뒷풀이 참석 여부 투표 뒷풀이 참석 여부 투표 뒷풀이 참석 여부 투표 뒷풀이 참석 여부 투표 뒷풀이 참석 여부 투표", status: .pending),
                .init(id: 6, contents: "7월 회비 납부", status: .pending)
            ]
        ),
        TodoOrganizationEntity(
            id: 3,
            name: "행복한 스터디",
            todos: [
                .init(id: 7, contents: "스터디 자료 준비", status: .pending)
            ]
        )
    ]
}
