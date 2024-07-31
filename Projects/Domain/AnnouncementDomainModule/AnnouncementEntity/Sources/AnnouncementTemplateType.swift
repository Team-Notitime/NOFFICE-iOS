//
//  AnnouncementTemplateType.swift
//  AnnouncementEntity
//
//  Created by DOYEON LEE on 7/22/24.
//

import Foundation

public enum AnnouncementTemplateType: CaseIterable, Identifiable, Equatable {
    /// A page that sets an end date and time.
    case date
    
    /// A page that specifies the event location.
    case location
    
    /// A page that lists todos that members need to complete by the end date.
    case todo
    
    /// A page that configures when to receive reminder push notifications.
    case notification
    
    public var id: Int {
        return AnnouncementTemplateType.allCases.firstIndex(of: self) ?? 0
    }
    
    public var title: String {
        switch self {
        case .date:
            return "날짜 · 시간"
        case .location:
            return "장소"
        case .todo:
            return "투두"
        case .notification:
            return "알림"
        }
    }
}
