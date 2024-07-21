//
//  AnnouncementTemplateType.swift
//  AnnouncementEntity
//
//  Created by DOYEON LEE on 7/22/24.
//

import Foundation

public enum AnnouncementTemplateType: CaseIterable, Identifiable, Equatable {
    case date
    case location
    case todo
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
