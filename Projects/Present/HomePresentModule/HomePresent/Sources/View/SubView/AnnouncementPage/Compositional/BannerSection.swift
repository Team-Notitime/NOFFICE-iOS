//
//  BannerSection.swift
//  HomePresent
//
//  Created by DOYEON LEE on 7/17/24.
//

import UIKit

import DesignSystem
import Assets

import RxSwift

struct BannerSection: CompositionalSection {
    var layout: CompositionalLayout = .init(
        groupLayout: .init(
            size: .init(width: .fractionalWidth(1.0), height: .absolute(100)),
            groupSpacing: 16,
            items: [
                .init(width: .fractionalWidth(1.0), height: .absolute(100))
            ],
            itemSpacing: 0
        ),
        sectionInset: .init(top: 0, leading: 0, bottom: 0, trailing: 0),
        scrollBehavior: .none
    )
    
    var identifier: String
    var items: [any CompositionalItem]
    
    init(
        identifier: String,
        items: [any CompositionalItem]
    ) {
        self.items = items
        self.identifier = identifier
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
}

final class BannerItem: CompositionalItem {
    // MARK: Compositional
    let binding: (BannerItemCell) -> Void
    
    // MARK: Data
    let userName: String
    let todayPrefixText: String
    let dateText: String
    
    // MARK: DisposeBag
    let disposeBag = DisposeBag()
    
    init(
        userName: String,
        todayPrefixText: String,
        dateText: String,
        _ binding: @escaping (BannerItemCell) -> Void = { _ in }
    ) {
        self.userName = userName
        self.todayPrefixText = todayPrefixText
        self.dateText = dateText
        self.binding = binding
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(userName)
        hasher.combine(todayPrefixText)
        hasher.combine(dateText)
    }
}

final class BannerItemCell: UIView, CompositionalItemCell {
    
    // MARK: UI Component
    lazy var banner = NofficeBanner()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    private func setup() {
        addSubview(banner)
        
        banner.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func configure(with item: BannerItem) {
        banner.userName = item.userName
        banner.todayPrefixText = item.todayPrefixText
        banner.dateText = item.dateText
    }
}
