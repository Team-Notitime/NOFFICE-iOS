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
    
    let date: Date?
    
    let place: String?
    
    let todoCount: Int?
    
    let body: String
    
    let createdDate: Date
    
    // MARK: DisposeBag
    let disposeBag = DisposeBag()
    
    init(
        id: Int,
        title: String,
        endDate: Date? = nil,
        place: String? = nil,
        todoCount: Int? = nil,
        body: String,
        createdDate: Date,
        onTap: @escaping () -> Void
    ) {
        self.id = id
        self.title = title
        self.date = endDate
        self.place = place
        self.todoCount = todoCount
        self.body = body
        self.createdDate = createdDate
        self.onTap = onTap
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

final class AnnouncementItemCell: UIView, CompositionalItemCell {
    // MARK: UI Constant
    private let badgeIconSize: CGFloat = 15
    
    private let badgeLabelTypo: Typo = .body2b
    
    // MARK: UI Component
    // - Stack view
    lazy var stackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = GlobalViewConstant.spacingUnit * 2
    }
    
    // - Title
    private lazy var titleLabel = UILabel().then {
        $0.setTypo(.body0b)
        $0.numberOfLines = 1
        $0.textColor = .grey800
    }
    
    // - Badge stack view
    private lazy var badgeStackView = BaseHStack(alignment: .leading) {
        [
            dateBadge,
            placeBadge,
            todoBadge,
            BaseSpacer()
        ]
    }
    
    // - Date badge
    private lazy var dateBadge = BaseBadge {
        [
            UIImageView(image: .iconCalendar).then {
                $0.setSize(width: 15, height: 15)
            },
            dateLabel
        ]
    }.then {
        $0.styled(color: .yellow, variant: .weak)
    }
    
    private lazy var dateLabel = UILabel().then {
        $0.setTypo(badgeLabelTypo)
        $0.setContentCompressionResistancePriority(.required, for: .horizontal)
    }
    
    // - Place badge
    private lazy var placeBadge = BaseBadge {
        [
            UIImageView(image: .iconCalendar).then {
                $0.setSize(width: badgeIconSize, height: badgeIconSize)
            },
            placeLabel
        ]
    }.then {
        $0.styled(color: .yellow, variant: .weak)
    }
    
    private lazy var placeLabel = UILabel().then {
        $0.setTypo(badgeLabelTypo)
    }
    
    // - Todo badge
    private lazy var todoBadge = BaseBadge {
        [
            UIImageView(image: .iconCheck).then {
                $0.setSize(width: badgeIconSize, height: badgeIconSize)
            },
            todoBadgeLabel
        ]
    }.then {
        $0.styled(color: .yellow, variant: .weak)
    }
    
    private lazy var todoBadgeLabel = UILabel().then {
        $0.setTypo(badgeLabelTypo)
    }
    
    // - Body
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
        
        stackView.addArrangedSubview(badgeStackView)
        
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
        
        if let date = item.date {
            dateBadge.isHidden = false
            dateLabel.text = date.toString(format: "MM / dd")
        } else {
            dateBadge.isHidden = true
        }
        
        if let place = item.place {
            placeBadge.isHidden = false
            placeLabel.text = place
        } else {
            placeBadge.isHidden = true
        }
        
        if let todoCount = item.todoCount, todoCount > 0 {
            todoBadge.isHidden = false
            todoBadgeLabel.text = "\(todoCount)"
        } else {
            todoBadge.isHidden = true
        }
        
        createdDateLabel.text = item.createdDate
            .toString(format: "yyyy.MM.dd(EE) HH:mm")
    }
}
