//
//  AnnouncementPageViewController.swift
//  HomePresent
//
//  Created by DOYEON LEE on 7/15/24.
//

import AnnouncementEntity
import DesignSystem
import Foundation
import Router
import RxCocoa
import RxSwift
import UIKit

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
            .debug(":::")
            .map { owner, organizations in
                [
                    BannerSection(
                        identifier: UUID().uuidString,
                        items: [
                            BannerItem(
                                userName: owner.reactor.currentState.member?.name ?? "",
                                todayPrefixText: "활기찬",
                                dateText: owner.getCurrentDayOfWeek()
                            )
                        ]
                    )
                ] + AnnouncementPageConverter
                    .convertToOrganizationSections(
                        organizations
                    ) { announcementSummary, organization in
                        Router.shared.push(
                            .announcementDetail(
                                announcementSummary: announcementSummary,
                                organization: organization
                            )
                        )
                    }
            }
            .bind(to: baseView.collectionView.sectionBinder)
            .disposed(by: disposeBag)
    }
    
    // MARK: Private
    
    // TODO: Usecase로 이동 필요
    func getCurrentDayOfWeek() -> String {
        let dateFormatter = DateFormatter()
        
        dateFormatter.locale = Locale(identifier: "ko_KR")
        
        dateFormatter.dateFormat = "EEEE"
        
        let currentDate = Date()
        
        return dateFormatter.string(from: currentDate)
    }
}
