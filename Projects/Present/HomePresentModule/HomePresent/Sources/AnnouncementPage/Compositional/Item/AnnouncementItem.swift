//
//  AnnouncementItem.swift
//  HomePresent
//
//  Created by DOYEON LEE on 7/17/24.
//

import UIKit

import DesignSystem
import Assets

import RxSwift
import RxCocoa
import RxGesture

final class AnnouncementItem: CompositionalItem {
    typealias Cell = AnnouncementItemCell
    
    // MARK: Event
    let onTap: () -> Void
    
    // MARK: Data
    let identifier: String = UUID().uuidString
    
    let state: NofficeAnnouncementCard.State
    
    let coverImageUrl: URL?
    
    let title: String?
    
    let date: String?
    
    let location: String?
    
    // MARK: DisposeBag
    let disposeBag = DisposeBag()
    
    // MARK: Initializer
    init(
        state: NofficeAnnouncementCard.State,
        coverImageUrl: URL? = nil,
        title: String? = nil,
        date: String? = nil,
        location: String? = nil,
        onTap: @escaping () -> Void = { }
    ) {
        self.state = state
        self.coverImageUrl = coverImageUrl
        self.title = title
        self.date = date
        self.location = location
        self.onTap = onTap
    }
    
    // MARK: Hasher
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
}

final class AnnouncementItemCell: UIView, CompositionalItemCell {
    // MARK: UI Component
    // - Organization Card component
    lazy var organizationCard = NofficeAnnouncementCard()
    
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
        organizationCard.state = item.state
        
        if let title = item.title,
           let date = item.date,
           let location = item.location {
            organizationCard.titleText = title
            organizationCard.dateText = date
            organizationCard.locationText = location
        }
        
        print("::: cover \(item.coverImageUrl)")
        organizationCard.coverImageUrl = item.coverImageUrl
        
        // action binding
        organizationCard.rx.tapGesture()
            .when(.recognized)
            .map { _ in }
            .subscribe(onNext: {
                item.onTap()
            })
            .disposed(by: disposeBag)
    }
}
