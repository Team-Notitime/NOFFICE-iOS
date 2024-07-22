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
    var layout: CompositionalLayout {
        .init(
            groupLayout: .init(
                size: .init(
                    width: .fractionalWidth(0.8),
                    height: .estimated(ComponentConstant.organizationCardHeight)
                ),
                groupSpacing: 16,
                items: [
                    .item(
                        size: .init(
                            width: .fractionalWidth(1.0),
                            height: .estimated(ComponentConstant.organizationCardHeight)
                        )
                    )
                ],
                itemSpacing: 0
            ),
            headerSize: .init(width: .fractionalWidth(1.0), height: .absolute(72)),
            sectionInset: .init(top: 0, leading: 16, bottom: 0, trailing: 30),
            scrollBehavior: .groupPaging
        )
    }
    
    // MARK: Data
    let identifier: String
    let organizationName: String
    let items: [any CompositionalItem]
    
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
