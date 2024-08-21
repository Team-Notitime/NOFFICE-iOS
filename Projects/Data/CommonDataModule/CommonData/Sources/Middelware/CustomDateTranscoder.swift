//
//  CustomDateTranscoder.swift
//  CommonData
//
//  Created by DOYEON LEE on 8/18/24.
//

import Foundation

import OpenAPIRuntime

public struct CustomDateTranscoder: DateTranscoder, @unchecked Sendable {
    private let FormatStringWithMillis = "yyyy-MM-dd'T'HH:mm:ss.SSS"
    private let FormatStringWithoutMillis = "yyyy-MM-dd'T'HH:mm:ss"

    private let lock: NSLock
    private let lockedFormatterWithMillis: DateFormatter
    private let lockedFormatterWithoutMillis: DateFormatter

    public init() {
        let formatterWithMillis = DateFormatter()
        formatterWithMillis.dateFormat = FormatStringWithMillis
        formatterWithMillis.timeZone = TimeZone(secondsFromGMT: 0)
        formatterWithMillis.locale = Locale(identifier: "en_US_POSIX")
        
        let formatterWithoutMillis = DateFormatter()
        formatterWithoutMillis.dateFormat = FormatStringWithoutMillis
        formatterWithoutMillis.timeZone = TimeZone(secondsFromGMT: 0)
        formatterWithoutMillis.locale = Locale(identifier: "en_US_POSIX")
        
        lock = NSLock()
        lock.name = "com.yourcompany.customdatetranscoder"
        lockedFormatterWithMillis = formatterWithMillis
        lockedFormatterWithoutMillis = formatterWithoutMillis
    }

    public func encode(_ date: Date) throws -> String {
        lock.lock()
        defer { lock.unlock() }
        return lockedFormatterWithMillis.string(from: date)
    }

    public func decode(_ dateString: String) throws -> Date {
        lock.lock()
        defer { lock.unlock() }
        
        // Try to parse with milliseconds format
        if let date = lockedFormatterWithMillis.date(from: dateString) {
            return date
        }
        
        // If parsing with milliseconds fails, try without milliseconds format
        if let date = lockedFormatterWithoutMillis.date(from: dateString) {
            return date
        }
        
        // If both formats fail, throw an error
        print("Invalid date string: \(dateString), expected formats: \(FormatStringWithMillis) or \(FormatStringWithoutMillis)")
        throw DecodingError.dataCorrupted(
            .init(codingPath: [], debugDescription: "Expected date string to be in \(FormatStringWithMillis) or \(FormatStringWithoutMillis) format.")
        )
    }
}

public extension DateTranscoder where Self == CustomDateTranscoder {
    static var custom: Self {
        CustomDateTranscoder()
    }
}
