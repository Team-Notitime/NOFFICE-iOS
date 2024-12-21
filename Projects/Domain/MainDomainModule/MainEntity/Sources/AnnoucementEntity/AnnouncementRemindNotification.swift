//
//  AnnouncementRemindNotification.swift
//  AnnouncementEntity
//
//  Created by DOYEON LEE on 7/23/24.
//

import Foundation

/**
 Enum representing the types of reminder notifications for an announcement.
 */
public enum AnnouncementRemindNotification: Codable, Equatable, Hashable {
    /// Notification to remind before a specified time interval
    case before(TimeInterval)
    
    /// Custom notification date
    case custom(Date)
    
    /// Predefined default time intervals for reminders
    public static var defaultIntervals: [TimeInterval] {
        return [
            0,                   // On time
            5 * 60,              // 5 minutes before
            10 * 60,             // 10 minutes before
            15 * 60,             // 15 minutes before
            30 * 60,             // 30 minutes before
            1 * 60 * 60,         // 1 hour before
            2 * 60 * 60,         // 2 hours before
            3 * 60 * 60,         // 3 hours before
            12 * 60 * 60,        // 12 hours before
            24 * 60 * 60,        // 1 day before
            48 * 60 * 60,        // 2 days before
            7 * 24 * 60 * 60     // 1 week before
        ]
    }
    
    /// Returns the default before interval as an array of `AnnouncementRemindNotification`
    public static var defaultBefore: [AnnouncementRemindNotification] {
        return defaultIntervals.map { AnnouncementRemindNotification.before($0) }
    }
    
    /// Converts the before interval to a human-readable string
    public func toString() -> String {
        switch self {
        case .before(let interval):
            return interval.toReadableString()
        case .custom(let date):
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            formatter.timeStyle = .short
            return formatter.string(from: date)
        }
    }
    
    /// Converts the before interval to a human-readable Korean string
    public func toKoreanString() -> String {
        switch self {
        case .before(let interval):
            return interval.toReadableKoreanString
        case .custom(let date):
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            formatter.timeStyle = .short
            formatter.locale = Locale(identifier: "ko_KR")
            return formatter.string(from: date)
        }
    }
    
    /// Returns the time interval in seconds for sorting purposes
    public var timeInterval: TimeInterval {
        switch self {
        case .before(let interval):
            return interval
        case .custom(let date):
            return date.timeIntervalSince1970
        }
    }
}

extension TimeInterval {
    /// Converts the time interval to a human-readable string
    func toReadableString() -> String {
        if self == 0 {
            return "On time"
        } else if self < 3600 {
            let minutes = Int(self / 60)
            return "\(minutes) minutes before"
        } else if self < 86400 {
            let hours = Int(self / 3600)
            return "\(hours) hours before"
        } else {
            let days = Int(self / 86400)
            if days % 7 == 0 {
                let weeks = days / 7
                return "\(weeks) weeks before"
            } else {
                return "\(days) days before"
            }
        }
    }
    
    /// Converts the time interval to a human-readable Korean string
    var toReadableKoreanString: String {
        if self == 0 {
            return "정각"
        } else if self < 3600 {
            let minutes = Int(self / 60)
            return "\(minutes)분 전"
        } else if self < 86400 {
            let hours = Int(self / 3600)
            return "\(hours)시간 전"
        } else {
            let days = Int(self / 86400)
            if days % 7 == 0 {
                let weeks = days / 7
                return "\(weeks)주 전"
            } else {
                return "\(days)일 전"
            }
        }
    }
}
