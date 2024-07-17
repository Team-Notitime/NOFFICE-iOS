//
//  HomeAnnouncementSection.swift
//  HomePresent
//
//  Created by DOYEON LEE on 7/17/24.
//

import UIKit

import DesignSystem
import Assets

import RxSwift
import RxGesture

struct OrganizationSection: CompositionalSection {
    typealias Header = OrganizationSectionHeaderView
    
    // MARK: Compositional
    var layout: CompositionalLayout = .init(
        groupLayout: .init(
            size: .init(width: .fractionalWidth(0.8), height: .estimated(300)),
            groupSpacing: 16,
            items: [
                .init(width: .fractionalWidth(1.0), height: .estimated(300))
            ],
            itemSpacing: 0
        ),
        headerSize: .init(width: .fractionalWidth(1.0), height: .absolute(72)),
        sectionInset: .init(top: 0, leading: 16, bottom: 0, trailing: 30),
        scrollBehavior: .groupPaging
    )
    
    // MARK: Data
    var identifier: String
    let organizationName: String
    var items: [any CompositionalItem]
    
    init(
        identifier: String,
        organizationName: String,
        items: [any CompositionalItem]
    ) {
        self.items = items
        self.identifier = identifier
        self.organizationName = organizationName
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
        hasher.combine(organizationName)
    }
}

class OrganizationSectionHeaderView: UIView, CompositionalReusableView {
    typealias Section = OrganizationSection
    
    // MARK: UI Component
    private lazy var label = UILabel().then {
        $0.textColor = .grey800
        $0.textAlignment = .left
        $0.setTypo(.heading4)
    }
    
    private lazy var icon = UIImageView(image: .iconChevronRight).then {
        $0.tintColor = .grey800
        $0.contentMode = .scaleAspectFit
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    // MARK: Setup
    private func setup() {
        addSubview(label)
        addSubview(icon)
        
        label.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.left.equalToSuperview().inset(14)
        }
        
        icon.snp.makeConstraints {
            $0.top.right.bottom.equalToSuperview()
        }
    }
    
    func configure(with section: Section) {
        label.text = section.organizationName
    }
}


final class AnnouncementItem: CompositionalItem {
    typealias Cell = AnnouncementItemCell
    
    // MARK: Data
    let identifier: String = UUID().uuidString // TODO: Server id로 교체
    let title: String
    let date: String
    let location: String
    
    let onTapAnnouncementCard = PublishSubject<Void>()
    
    // MARK: DisposeBag
    let disposeBag = DisposeBag()
    
    // MARK: Initializer
    init(
        title: String,
        date: String,
        location: String
    ) {
        self.title = title
        self.date = date
        self.location = location
    }
    
    // MARK: Hasher
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
}

final class AnnouncementItemCell: UIView, CompositionalItemCell {
    // MARK: UI Component
    lazy var organizationCard = NofficeOrganizationCard()
    
    // MARK: DisposeBag
    private var disposeBag = DisposeBag()
    
    // MARK: Initializer
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    // MARK: Setup
    private func setup() {
        addSubview(organizationCard)
        
        organizationCard.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func configure(with item: AnnouncementItem) {
        // data binding
        organizationCard.titleText = item.title
        organizationCard.dateText = item.date
        organizationCard.locationText = item.location
        
        // action binding
        organizationCard.rx.tapGesture()
            .when(.recognized)
            .map { _ in }
            .bind(to: item.onTapAnnouncementCard)
            .disposed(by: disposeBag)
    }
}
