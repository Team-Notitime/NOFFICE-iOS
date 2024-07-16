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

struct OrganizationSection: CompositionalSection {
    typealias Header = OrganizationSectionHeaderView
    
    var layout: CompositionalLayout = .init(
        groupLayout: .init(
            size: .init(width: .fractionalWidth(0.8), height: .absolute(300)),
            groupSpacing: 16,
            items: [
                .init(width: .fractionalWidth(1.0), height: .absolute(300))
            ],
            itemSpacing: 0
        ),
        headerSize: .init(width: .fractionalWidth(1.0), height: .absolute(72)),
        sectionInset: .init(top: 0, leading: 30, bottom: 0, trailing: 30),
        scrollBehavior: .groupPaging
    )
    
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

final class AnnouncementItem: CompositionalItem {
    let binding: (AnnouncementItemCell) -> Void
    var identifier: String = UUID().uuidString
    var value: String = ""
    
    let disposeBag = DisposeBag()
    
    init(
        identifier: String,
        value: String,
        _ binding: @escaping (AnnouncementItemCell) -> Void
    ) {
        self.identifier = identifier
        self.value = value
        self.binding = binding
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
        hasher.combine(value)
    }
}

final class AnnouncementItemCell: UIView, CompositionalItemCell {
    var itemType: AnnouncementItem.Type {
        return Item.self
    }
    
    lazy var organizationCard = NofficeGroupCard()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    private func setup() {
        addSubview(organizationCard)
        
        organizationCard.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func configure(with item: AnnouncementItem) {
        
    }
}

class OrganizationSectionHeaderView: UIView, CompositionalReusableView {
    typealias Section = OrganizationSection
    
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
    
    private func setup() {
        addSubview(label)
        addSubview(icon)
        
        label.snp.makeConstraints {
            $0.top.left.bottom.equalToSuperview()
        }
        
        icon.snp.makeConstraints {
            $0.top.right.bottom.equalToSuperview()
        }
    }
    
    func configure(with section: Section) {
        label.text = section.organizationName
    }
}
