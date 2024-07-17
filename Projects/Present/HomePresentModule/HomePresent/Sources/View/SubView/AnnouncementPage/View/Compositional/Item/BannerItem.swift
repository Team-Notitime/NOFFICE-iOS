//
//  BannerItem.swift
//  HomePresent
//
//  Created by DOYEON LEE on 7/17/24.
//

import UIKit

import DesignSystem
import Assets

import RxSwift

final class BannerItem: CompositionalItem {
    typealias Cell = BannerItemCell
    
    // MARK: Data
    let userName: String
    let todayPrefixText: String
    let dateText: String
    
    // MARK: DisposeBag
    let disposeBag = DisposeBag()
    
    init(
        userName: String,
        todayPrefixText: String,
        dateText: String
    ) {
        self.userName = userName
        self.todayPrefixText = todayPrefixText
        self.dateText = dateText
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
