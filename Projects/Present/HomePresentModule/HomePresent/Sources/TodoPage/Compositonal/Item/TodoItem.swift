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
    let onTap: () -> Bool
    
    // MARK: Data
    let id: Int
    let contents: String
    
    // MARK: DisposeBag
    let disposeBag = DisposeBag()
    
    init(
        id: Int,
        contents: String,
        onTap: @escaping () -> Bool
    ) {
        self.id = id
        self.contents = contents
        self.onTap = onTap
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
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
        
        todo.rx.tapGesture()
            .subscribe(onNext: { [weak self] _ in
                let result = item.onTap()
                
                print(result)
                
                self?.todo.status = result ? .done : .pending
            })
            .disposed(by: disposeBag)
    }
}
