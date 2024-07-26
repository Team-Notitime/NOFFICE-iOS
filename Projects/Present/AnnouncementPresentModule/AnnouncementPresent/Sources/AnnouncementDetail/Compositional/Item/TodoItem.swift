//
//  TodoItem.swift
//  AnnouncementPresent
//
//  Created by DOYEON LEE on 7/26/24.
//

import UIKit

import AnnouncementEntity
import DesignSystem
import Assets

import RxSwift

final class TodoItem: CompositionalItem {
    typealias Cell = TodoItemCell
    
    // MARK: Event
    let onTap: () -> Void
    
    // MARK: Data
    let id: Int
    let contents: String
    let status: Status
    
    // MARK: DisposeBag
    let disposeBag = DisposeBag()
    
    init(
        id: Int,
        contents: String,
        status: Status,
        onTap: @escaping () -> Void
    ) {
        self.id = id
        self.contents = contents
        self.status = status
        self.onTap = onTap
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(contents)
        hasher.combine(status)
    }
}

extension TodoItem {
    enum Status {
        case done
        case pending
    }
}

final class TodoItemCell: UIView, CompositionalItemCell {
    // MARK: UI Component
    lazy var todo = NofficeTodo<AnnouncementTodoEntity>().then {
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
        
        switch item.status {
        case .done:
            todo.status = .done
        case .pending:
            todo.status = .pending
        }
        
        todo.rx.tapGesture()
            .when(.recognized)
            .subscribe(onNext: { _ in
                item.onTap()
            })
            .disposed(by: disposeBag)
    }
}
