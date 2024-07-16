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
    let headerBinding: (OrganizationSectionHeaderView) -> Void
    
    init(
        identifier: String,
        organizationName: String,
        items: [any CompositionalItem],
        headerBinding: @escaping (OrganizationSectionHeaderView) -> Void
    ) {
        self.items = items
        self.identifier = identifier
        self.organizationName = organizationName
        self.headerBinding = headerBinding
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
        hasher.combine(organizationName)
    }
}

final class AnnouncementItem: CompositionalItem {
    // MARK: Compositional
    let binding: (AnnouncementItemCell) -> Void
    
    // MARK: Data
    var identifier: String = UUID().uuidString
    var value: String = ""
    
    let onTapAnnouncementCard = PublishSubject<Void>()
    
    // MARK: DisposeBag
    let disposeBag = DisposeBag()
    
    // MARK: Initializer
    init(
        identifier: String,
        value: String,
        _ binding: @escaping (AnnouncementItemCell) -> Void
    ) {
        self.identifier = identifier
        self.value = value
        self.binding = binding
    }
    
    // MARK: Hasher
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
        hasher.combine(value)
    }
}

final class AnnouncementItemCell: UIView, CompositionalItemCell {
    // MARK: UI Component
    lazy var organizationCard = NofficeGroupCard()
    
    // MARK: Initializer
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
        bind()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        
    }
    
    private var disposeBag = DisposeBag()
    
    // MARK: Setup
    private func setup() {
        addSubview(organizationCard)
        
        organizationCard.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func bind() {

    }
    
    func configure(with item: AnnouncementItem) {
        organizationCard.rx.tapGesture()
            .when(.recognized)
            .map { _ in }
            .bind(to: item.onTapAnnouncementCard)
            .disposed(by: disposeBag)
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
