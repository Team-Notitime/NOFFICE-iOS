//
//  TodoSection.swift
//  HomePresent
//
//  Created by DOYEON LEE on 7/21/24.
//

import UIKit

import TodoEntity
import DesignSystem
import Assets

import RxSwift

struct TodoSection: CompositionalSection {
    typealias Header = TodoSectionHeaderView
    
    var layout: CompositionalLayout {
        .init(
            groupLayout: .init(
                size: .init(width: .fractionalWidth(1.0), height: .estimated(42)),
                groupSpacing: 8,
                items: [
                    .item(size: .init(width: .fractionalWidth(1.0), height: .estimated(42)))
                ],
                itemSpacing: 0
            ),
            headerSize: .init(width: .fractionalWidth(1.0), height: .absolute(48)),
            sectionInset: .init(
                top: 0,
                leading: GlobalViewConstant.PagePadding,
                bottom: GlobalViewConstant.PagePadding * 2,
                trailing: GlobalViewConstant.PagePadding
            ),
            scrollBehavior: .none
        )
    }
    
    var organizationId: Int
    var organizationName: String
    var items: [any CompositionalItem]
    
    init(
        organizationId: Int,
        organizationName: String,
        items: [any CompositionalItem]
    ) {
        self.organizationId = organizationId
        self.organizationName = organizationName
        self.items = items
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(organizationId)
    }
}

class TodoSectionHeaderView: UIView, CompositionalReusableView {
    // MARK: UI Component
    // - Background
    private lazy var backgroundView = UIView().then {
        $0.backgroundColor = .grey50
        $0.layer.cornerRadius = 8
        $0.layer.masksToBounds = true
    }
    
    // - Organization name label
    private lazy var label = UILabel().then {
        $0.textColor = .grey800
        $0.textAlignment = .left
        $0.setTypo(.heading4)
    }
    
    // - Right arrow icon
    private lazy var icon = UIImageView(image: .iconChevronRight).then {
        $0.tintColor = .grey800
        $0.contentMode = .scaleAspectFit
    }
    
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
        addSubview(backgroundView)
        backgroundView.addSubview(label)
        backgroundView.addSubview(icon)
        
        backgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        label.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.left.equalToSuperview()
                .inset(18)
        }
        
        icon.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.right.equalToSuperview()
                .inset(18)
        }
    }
    
    func configure(with section: TodoSection) {
        label.text = section.organizationName
    }
}
