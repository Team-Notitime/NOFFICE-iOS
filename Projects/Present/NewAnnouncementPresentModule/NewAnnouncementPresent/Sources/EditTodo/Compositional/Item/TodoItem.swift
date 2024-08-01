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
    
    // MARK: Event
    let onLongPress: () -> Void
    
    // MARK: Data
    let id: UUID = UUID()
    let content: String
    
    // MARK: DisposeBag
    let disposeBag = DisposeBag()
    
    init(
        content: String,
        onLongPress: @escaping () -> Void
    ) {
        self.content = content
        self.onLongPress = onLongPress
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
        todo.text = item.content
        
        todo.rx.longPressGesture(
            configuration: { gestureRecognizer, _ in
                gestureRecognizer.minimumPressDuration = 0.2
            }
        )
        .when(.began)
        .subscribe(onNext: { [weak self] _ in
            guard let self = self else { return }
            
            self.animatePressDown()
            item.onLongPress()
        })
        .disposed(by: disposeBag)
        
        todo.rx.longPressGesture()
            .when(.ended, .cancelled)
            .subscribe(onNext: { [weak self] _ in
                self?.animatePressUp()
            })
            .disposed(by: disposeBag)
    }
    
    private func animatePressDown() {
        UIView.animate(withDuration: 0.1, delay: 0, options: [.curveEaseInOut]) {
            self.todo.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }
    }
    
    private func animatePressUp() {
        UIView.animate(withDuration: 0.1, delay: 0, options: [.curveEaseInOut]) {
            self.todo.transform = .identity
        }
    }
}
