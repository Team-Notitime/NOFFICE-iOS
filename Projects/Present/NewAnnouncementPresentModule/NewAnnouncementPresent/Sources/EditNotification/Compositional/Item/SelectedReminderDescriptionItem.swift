//
//  SelectedReminderDescriptionItem.swift
//  NewAnnouncementPresent
//
//  Created by DOYEON LEE on 7/23/24.
//

import UIKit

import DesignSystem
import Assets

import RxSwift

final class SelectedReminderDescriptionItem: CompositionalItem {
    typealias Cell = SelectedReminderDescriptionItemCell
    
    // MARK: Data
    let id: UUID = UUID()
    
    // MARK: DisposeBag
    let disposeBag = DisposeBag()
    
    init() { }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

final class SelectedReminderDescriptionItemCell: UIView, CompositionalItemCell {
    // MARK: UI Component
    lazy var label = UILabel().then {
        $0.text = "에 알림을 보낼래요"
        $0.textColor = .grey700
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
    }
    
    func configure(with item: SelectedReminderDescriptionItem) { }
}
