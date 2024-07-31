//
//  AnnouncementItem.swift
//  OrganizationPresent
//
//  Created by DOYEON LEE on 8/1/24.
//

import UIKit

import DesignSystem
import Assets

import RxSwift

final class AnnouncementItem: CompositionalItem {
    typealias Cell = AnnouncementItemCell
    
    // MARK: Event
    let onTap: () -> Void
    
    // MARK: Data
    let id: Int
    
    let title: String
    
    let endDate: Date?
    
    let place: String?
    
    let body: String
    
    let createdDate: Date
    
    // MARK: DisposeBag
    let disposeBag = DisposeBag()
    
    init(
        id: Int,
        title: String,
        endDate: Date? = nil,
        place: String? = nil,
        body: String,
        createdDate: Date,
        onTap: @escaping () -> Void
    ) {
        self.id = id
        self.title = title
        self.endDate = endDate
        self.place = place
        self.body = body
        self.createdDate = createdDate
        self.onTap = onTap
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

final class AnnouncementItemCell: UIView, CompositionalItemCell {
    // MARK: UI Component
    lazy var stackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = GlobalViewConstant.spacingUnit * 2
    }
    
    private lazy var titleLabel = UILabel().then {
        $0.setTypo(.body0b)
        $0.numberOfLines = 1
        $0.textColor = .grey800
    }
    
    private lazy var endDateLabel = UILabel().then {
        $0.setTypo(.body2b)
    }
    
    private lazy var placeLabel = UILabel().then {
        $0.setTypo(.body2b)
    }
    
    private lazy var bodyLabel = UILabel().then {
        $0.setTypo(.body2)
        $0.numberOfLines = 2
        $0.textColor = .grey600
    }
    
    private lazy var createdDateLabel = UILabel().then {
        $0.setTypo(.body3)
        $0.textColor = .grey400
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
        backgroundColor = .fullWhite
        
        addSubview(stackView)
        
        stackView.addArrangedSubview(titleLabel)
        
        stackView.addArrangedSubview(endDateLabel)
        
        stackView.addArrangedSubview(placeLabel)
        
        stackView.addArrangedSubview(bodyLabel)
        
        stackView.addArrangedSubview(createdDateLabel)
        
        stackView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
                .inset(20)
            $0.left.right.equalToSuperview()
                .inset(10)
        }
        
        
    }
    
    func configure(with item: AnnouncementItem) {
        titleLabel.text = item.title
        
        bodyLabel.text = item.body
        
        createdDateLabel.text = item.createdDate
            .toString(format: "yyyy.MM.dd(EE) HH:mm")

    }
}
