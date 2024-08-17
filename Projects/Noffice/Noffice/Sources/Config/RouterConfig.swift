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
import SignupPresent

struct RouterConfig {
    @MainActor static func setup() {
        Router.shared.resolvePresentable = { presentableType in
            switch presentableType {
                // - New announcement
            case .newAnnouncement:
                return NewAnnouncementFunnelViewController()
                
                // - Announcement detail
            case let .announcementDetail(announcementEntity):
                return AnnouncementDetailViewController(
                    announcement: announcementEntity
                )
                
                // - New organization
            case .newOrganization:
                return NewOrganizationFunnelViewController()
                
                // - Mypage
            case .mypage:
                return MypageViewController()
                
                // - Signup
            case .signup:
                return SignupViewController()
            }
        }
    }
}
