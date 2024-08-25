//
//  Presentable.swift
//  Router
//
//  Created by DOYEON LEE on 8/1/24.
//

import AnnouncementEntity
import OrganizationEntity

/// Define the types of views that can be navigated between using a router
public enum Routable {
    case newAnnouncement
    case announcementDetail(
        announcementSummary: AnnouncementSummaryEntity,
        organization: AnnouncementOrganizationEntity
    )
    case newOrganization
    case organizationDetail(OrganizationSummaryEntity)
    case mypage
    case signup
}
