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

struct TimeOptionItem: CompositionalItem {
    typealias Cell = TimeOptionItemCell
    
    // MARK: Event
    /// Return true if the item is selected
    let onSelect: () -> Bool
    
    // MARK: Data
    let timeText: String
    let isSelected: Bool
    
    // MARK: DisposeBag
    let disposeBag = DisposeBag()
    
    init(
        timeText: String,
        isSelected: Bool,
        onSelect: @escaping () -> Bool
    ) {
        self.timeText = timeText
        self.isSelected = isSelected
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
        $0.setSize(width: 20, height: 20)
        $0.tintColor = .blue500
        $0.layer.opacity = 0.0
    }
    
    lazy var divider = BaseDivider()
    
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
        
        addSubview(divider)
        
        timeLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview()
        }
        
        checkIcon.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.right.equalToSuperview()
        }
        
        divider.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.left.right.equalToSuperview()
            $0.height.equalTo(1)
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
                
                // Update UI
                UIView.animate(withDuration: 0.2) {
                    owner.checkIcon.layer.opacity = isSelected ? 1.0 : 0.0
                }
            })
            .disposed(by: disposeBag)
    }
}
