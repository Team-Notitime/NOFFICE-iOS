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
    
    // MARK: Event
    let onTap: () -> Void
    
    // MARK: Data
    let id: Int
    let status: TodoItemEntity.Status
    let contents: String
    
    // MARK: DisposeBag
    let disposeBag = DisposeBag()
    
    init(
        id: Int,
        status: TodoItemEntity.Status,
        contents: String,
        onTap: @escaping () -> Void
    ) {
        self.id = id
        self.status = status
        self.contents = contents
        self.onTap = onTap
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(status)
        hasher.combine(contents)
    }
}

final class TodoItemCell: UIView, CompositionalItemCell {
    // MARK: UI Component
    lazy var todo = NofficeTodo<TodoItemEntity>().then {
        $0.automaticToggle = false
    }
    
    // MARK: DisposeBag
    private let disposeBag = DisposeBag()
    
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
        
        todo.status = item.status == .pending ? .pending : .done
        
        todo.rx.tapGesture()
            .when(.recognized)
            .subscribe(onNext: { _ in
                item.onTap()
            })
            .disposed(by: disposeBag)
    }
}
