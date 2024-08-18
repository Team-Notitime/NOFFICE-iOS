//
//  AnnouncementPageViewController.swift
//  HomePresent
//
//  Created by DOYEON LEE on 7/15/24.
//

import UIKit

import Router
import DesignSystem
import AnnouncementEntity

import RxSwift
import RxCocoa

class AnnouncementPageViewController: BaseViewController<AnnouncementPageView> {
    // MARK: Reactor
    private let reactor = AnnouncementPageReactor()
    
    // MARK: Life cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        reactor.action.onNext(.viewWillAppear)
    }
    
    // MARK: Setup
    override func setupStateBind() {
        reactor.state.map { $0.organizations }
            .withUnretained(self)
            .map { owner, organizations in
                [
                    BannerSection(
                        identifier: UUID().uuidString,
                        items: [
                            BannerItem(
                                userName: owner.reactor.currentState.member?.name ?? "",
                                todayPrefixText: "활기찬",
                                dateText: "화요일"
                            )
                        ]
                    )
                ] + AnnouncementPageConverter
                    .convertToOrganizationSections(
                        organizations
                    ) { announcement in
                        Router.shared.push(
                            .announcementDetail(
                                announcementEntity: announcement
                            )
                        )
                    }
            }
            .bind(to: baseView.collectionView.sectionBinder)
            .disposed(by: disposeBag)
    }
}
