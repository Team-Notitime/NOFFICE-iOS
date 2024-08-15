//
//  RouterConfig.swift
//  Noffice
//
//  Created by DOYEON LEE on 8/1/24.
//

import Router
import AnnouncementPresent
import NewAnnouncementPresent
import NewOrganizationPresent
import MypagePresent

struct RouterConfig {
    static func setup() {
        Router.shared.resolvePresentable = { presentableType in
            switch presentableType {
            case .newAnnouncement:
                return NewAnnouncementFunnelViewController()
                
            case let .announcementDetail(announcementEntity):
                return AnnouncementDetailViewController(
                    announcement: announcementEntity
                )
                
            case .newOrganization:
                return NewOrganizationFunnelViewController()
                
            case .mypage:
                return MypageViewController()
            }
        }
    }
}
