//
//  AnnouncementPageView.swift
//  HomePresent
//
//  Created by DOYEON LEE on 7/15/24.
//
import UIKit

import DesignSystem

import RxSwift
import SnapKit
import Then

public class AnnouncementPageView: BaseView {
    // MARK: Data source
    
    // MARK: UI Component
    private lazy var banner = NofficeBanner().then {
        $0.userName = "이즌"
        $0.todayPrefixText = "활기찬"
        $0.dateText = "8월 27일 화요일"
    }
    
    let collectionView = CompositionalCollectionView()
    
    lazy var sectionsSubject = BehaviorSubject<[any CompositionalSection]>(value: sections)
    
    var sections: [any CompositionalSection] = [
        BannerSection(
            identifier: UUID().uuidString,
            items: [
                BannerItem(
                    userName: "이즌",
                    todayPrefixText: "활기찬",
                    dateText: "8월 27일 화요일"
                )
            ]
        ),
        OrganizationSection(
            identifier: UUID().uuidString,
            organizationName: "CMC 15th",
            items: [
                AnnouncementItem(identifier: UUID().uuidString, value: "Item3") { _ in
                    
                },
                AnnouncementItem(identifier: UUID().uuidString, value: "Item4") { _ in
                    
                },
                AnnouncementItem(identifier: UUID().uuidString, value: "Item4") { _ in
                    
                },
                AnnouncementItem(identifier: UUID().uuidString, value: "Item4") { _ in
                    
                }
            ]
        ),
        OrganizationSection(
            identifier: UUID().uuidString,
            organizationName: "CMC 15th",
            items: [
                AnnouncementItem(identifier: UUID().uuidString, value: "Item3") { _ in
                    
                },
                AnnouncementItem(identifier: UUID().uuidString, value: "Item4") { _ in
                    
                },
                AnnouncementItem(identifier: UUID().uuidString, value: "Item4") { _ in
                    
                },
                AnnouncementItem(identifier: UUID().uuidString, value: "Item4") { _ in
                    
                }
            ]
        )
    ]
    
    // MARK: Setup
    public override func setupHierarchy() {
        addSubview(collectionView)
    }
    
    public override func setupLayout() {
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    public override func setupBind() { 
        collectionView.bindSections(
            to: sectionsSubject.asObservable()
        )
        .disposed(by: disposeBag)
    }
}
