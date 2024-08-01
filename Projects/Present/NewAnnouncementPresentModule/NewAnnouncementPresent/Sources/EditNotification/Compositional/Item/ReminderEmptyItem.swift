//
//  ReminderEmptyItem.swift
//  NewAnnouncementPresent
//
//  Created by DOYEON LEE on 7/25/24.
//

import UIKit

import DesignSystem
import Assets

import RxSwift

final class ReminderEmptyItem: CompositionalItem {
    typealias Cell = ReminderEmptyItemCell
    
    // MARK: Data
    let id: String = "\(String(describing: ReminderEmptyItem.self))))"
    
    // MARK: DisposeBag
    let disposeBag = DisposeBag()
    
    init() { }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

final class ReminderEmptyItemCell: UIView, CompositionalItemCell {
    // MARK: UI Component
    lazy var label = UILabel().then {
        $0.text = "알림은 필요 없어요"
        $0.textColor = .grey400
        $0.setTypo(.body1b)
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
        addSubview(label)
        
        label.snp.makeConstraints {
            $0.edges.equalToSuperview()
                .inset(4)
        }
        
        backgroundColor = .grey50
        layer.cornerRadius = 10
        layer.masksToBounds = true
    }
    
    func configure(with item: ReminderEmptyItem) { }
}
