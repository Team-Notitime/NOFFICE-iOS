//
//  CustomDateTranscoder.swift
//  CommonData
//
//  Created by DOYEON LEE on 8/18/24.
//

import Foundation

import OpenAPIRuntime

public struct CustomDateTranscoder: DateTranscoder, @unchecked Sendable {

    private let lock: NSLock
    private let lockedFormatter: DateFormatter

    public init() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        lock = NSLock()
        lock.name = "com.yourcompany.customdatetranscoder"
        lockedFormatter = formatter
    }

    public func encode(_ date: Date) throws -> String {
        lock.lock()
        defer { lock.unlock() }
        return lockedFormatter.string(from: date)
    }

    public func decode(_ dateString: String) throws -> Date {
        lock.lock()
        defer { lock.unlock() }
        guard let date = lockedFormatter.date(from: dateString) else {
            throw DecodingError.dataCorrupted(
                .init(codingPath: [], debugDescription: "Expected date string to be in 'YYYY-MM-DDTHH:mm:ss' format.")
            )
        }
        return date
    }
}

public extension DateTranscoder where Self == CustomDateTranscoder {
    static var custom: Self {
        CustomDateTranscoder()
    }
}
