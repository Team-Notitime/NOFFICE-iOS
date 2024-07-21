//
//  TodoItem.swift
//  HomePresent
//
//  Created by DOYEON LEE on 7/21/24.
//

import UIKit

import TodoEntity
import DesignSystem
import Assets

import RxSwift

final class TodoItem: CompositionalItem {
    typealias Cell = TodoItemCell
    
    // MARK: Data
    let id: Int
    let contents: String
    
    // MARK: DisposeBag
    let disposeBag = DisposeBag()
    
    init(
        id: Int,
        contents: String
    ) {
        self.id = id
        self.contents = contents
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(contents)
    }
}

final class TodoItemCell: UIView, CompositionalItemCell {
    // MARK: UI Component
    lazy var todo = NofficeTodo<TodoItemEntity>()
    
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
        todo.text = item.contents
    }
}
