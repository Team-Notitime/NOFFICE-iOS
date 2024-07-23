//
//  TimeOptionItem.swift
//  NewAnnouncementPresent
//
//  Created by DOYEON LEE on 7/23/24.
//

import UIKit

import DesignSystem
import Assets

import RxSwift
import RxGesture

final class TimeOptionItem: CompositionalItem {
    typealias Cell = TimeOptionItemCell
    
    // MARK: Event
    /// Return true if the item is selected
    let onSelect: () -> Bool
    
    // MARK: Data
    let timeText: String
    var isSelected: Bool = false
    
    // MARK: DisposeBag
    let disposeBag = DisposeBag()
    
    init(
        timeText: String,
        onSelect: @escaping () -> Bool
    ) {
        self.timeText = timeText
        self.onSelect = onSelect
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(timeText)
    }
}

final class TimeOptionItemCell: UIView, CompositionalItemCell {
    typealias Item = TimeOptionItem
    
    // MARK: UI Component
    lazy var timeLabel = UILabel().then {
        $0.setTypo(.body1)
        $0.tintColor = .grey800
    }
    
    lazy var checkIcon = UIImageView(image: .iconCheck).then {
        $0.setSize(width: 24, height: 24)
        $0.tintColor = .blue500
        $0.layer.opacity = 0.0
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
        addSubview(timeLabel)
        
        addSubview(checkIcon)
        
        timeLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(8)
            $0.left.equalToSuperview()
        }
        
        checkIcon.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(8)
            $0.right.equalToSuperview()
        }
    }
    
    func configure(with item: Item) {
        timeLabel.text = item.timeText
        
        checkIcon.layer.opacity = item.isSelected ? 1.0 : 0.0
        
        self.rx.tapGesture()
            .when(.recognized)
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                // Call onSelect and get reactor result
                let isSelected = item.onSelect()
                
                // Update item
                item.isSelected = isSelected
                
                // Update UI
                owner.checkIcon.layer.opacity = isSelected ? 1.0 : 0.0
            })
            .disposed(by: disposeBag)
    }
}
