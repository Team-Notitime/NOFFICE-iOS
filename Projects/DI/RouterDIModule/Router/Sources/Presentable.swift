//
//  Presentable.swift
//  Router
//
//  Created by DOYEON LEE on 8/1/24.
//

import AnnouncementEntity

/// Define the types of views that can be navigated between using a router
public enum Presentable: Hashable {
    case newAnnouncement
    case announcementDetail(announcementEntity: AnnouncementEntity)
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(caseName)
    }

    /// Case name excluding associated values
    private var caseName: String {
        let mirror = Mirror(reflecting: self)
        return String(describing: mirror.children.first?.label ?? "")
    }

    public static func == (lhs: Presentable, rhs: Presentable) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}
