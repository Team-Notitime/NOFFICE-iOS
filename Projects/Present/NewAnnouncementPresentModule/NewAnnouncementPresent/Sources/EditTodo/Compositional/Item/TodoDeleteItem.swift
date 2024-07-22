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

final class TodoDeleteItem: CompositionalItem {
    typealias Cell = TodoDeleteItemCell
    
    // MARK: Data
    let id: Int
    let content: String
    
    // MARK: DisposeBag
    let disposeBag = DisposeBag()
    
    init(
        id: Int,
        content: String
    ) {
        self.id = id
        self.content = content
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(content)
    }
}

final class TodoDeleteItemCell: UIView, CompositionalItemCell {
    // MARK: UI Component
    let trashIcon = UIImageView(image: .iconBell).then {
        $0.setSize(width: 22, height: 22)
        $0.tintColor = .red500
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
        addSubview(trashIcon)
        
        trashIcon.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        applyRoundedCorners()
    }
    
    private func applyRoundedCorners() {
        let path = UIBezierPath(
            roundedRect: bounds,
            byRoundingCorners: [.topLeft, .bottomLeft],
            cornerRadii: CGSize(width: 8, height: 8)
        )
        
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    func configure(with item: TodoDeleteItem) {
        backgroundColor = .red500.withAlphaComponent(0.2)
    }
}
