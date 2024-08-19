//
//  Presentable.swift
//  Router
//
//  Created by DOYEON LEE on 8/1/24.
//

import AnnouncementEntity

/// Define the types of views that can be navigated between using a router
public enum Presentable {
    case newAnnouncement
    case announcementDetail(announcementSummary: AnnouncementSummaryEntity)
    case newOrganization
    case mypage
    case signup
}
