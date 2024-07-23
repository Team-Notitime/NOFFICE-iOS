//
//  TodoItem.swift
//  NewAnnouncementPresent
//
//  Created by DOYEON LEE on 7/22/24.
//

import UIKit

import TodoEntity
import DesignSystem
import Assets

import RxSwift

final class TodoItem: CompositionalItem {
    typealias Cell = TodoItemCell
    
    // MARK: Data
    let id: UUID = UUID()
    let content: String
    
    // MARK: DisposeBag
    let disposeBag = DisposeBag()
    
    init(
        content: String
    ) {
        self.content = content
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(content)
    }
}

final class TodoItemCell: UIView, CompositionalItemCell {
    // MARK: UI Component
    lazy var todo = NofficeTodo<TodoItemEntity>().then {
        $0.automaticToggle = false
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    private func setup() {
        addSubview(todo)
        
        todo.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func configure(with item: TodoItem) {
        todo.text = item.content
    }
}
