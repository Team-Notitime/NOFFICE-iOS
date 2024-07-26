//
//  SelectedReminderItem.swift
//  NewAnnouncementPresent
//
//  Created by DOYEON LEE on 7/23/24.
//

import UIKit

import DesignSystem
import Assets

import RxSwift

final class ReminderItem: CompositionalItem {
    typealias Cell = SelectedReminderItemCell
    
    // MARK: Data
    let id: UUID = UUID()
    
    let timeText: String
    
    // MARK: DisposeBag
    let disposeBag = DisposeBag()
    
    init(
        timeText: String
    ) {
        self.timeText = timeText
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(timeText)
    }
}

final class SelectedReminderItemCell: UIView, CompositionalItemCell {
    // MARK: UI Component
    lazy var badgeLabel = UILabel().then {
        $0.setTypo(.body2b)
    }
    
    lazy var badge = BaseBadge {
        [
            badgeLabel
        ]
    }.then {
        $0.styled(color: .blue, variant: .weak)
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
        addSubview(badge)
        
        badge.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func configure(with item: ReminderItem) {
        badgeLabel.text = item.timeText
    }
}
