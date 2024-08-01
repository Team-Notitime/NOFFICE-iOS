//
//  TodoDeleteItem.swift
//  NewAnnouncementPresent
//
//  Created by DOYEON LEE on 7/22/24.
//

import UIKit

import TodoEntity
import DesignSystem
import Assets

import RxSwift

@available(*, deprecated, message: "Use long press instead.")
final class TodoDeleteItem: CompositionalItem {
    typealias Cell = TodoDeleteItemCell
    
    // MARK: Event
    let delete: () -> Void
    
    // MARK: Data
    let id: Int
    let content: String
    
    // MARK: DisposeBag
    let disposeBag = DisposeBag()
    
    init(
        id: Int,
        content: String,
        delete: @escaping () -> Void
    ) {
        self.id = id
        self.content = content
        self.delete = delete
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(content)
    }
}

@available(*, deprecated, message: "Use long press instead.")
final class TodoDeleteItemCell: UIView, CompositionalItemCell {
    // MARK: UI Component
    let trashIcon = UIImageView(image: .iconTrash).then {
        $0.setSize(width: 22, height: 22)
        $0.tintColor = .red500
    }
    
    lazy var rightBackgroundView = UIView().then {
        $0.backgroundColor = .red500.withAlphaComponent(0.2)
    }
    
    // MARK: DisposeBag
    let disposeBag = DisposeBag()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    private func setup() {
        addSubview(trashIcon)
        
        addSubview(rightBackgroundView)
        
        trashIcon.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        rightBackgroundView.snp.makeConstraints {
            $0.left.equalTo(self.snp.left)
            $0.width.equalTo(400)
            $0.height.equalTo(self.snp.height)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        applyRoundedCorners()
    }
    
    private func applyRoundedCorners() {
        let path = UIBezierPath(
            roundedRect: rightBackgroundView.bounds,
            byRoundingCorners: [.topLeft, .bottomLeft],
            cornerRadii: CGSize(width: 8, height: 8)
        )
        
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        rightBackgroundView.layer.mask = mask
    }
    
    func configure(with item: TodoDeleteItem) {
        self.rx.tapGesture()
            .when(.recognized)
            .subscribe(onNext: { _ in
                item.delete()
            })
            .disposed(by: disposeBag)
    }
}
