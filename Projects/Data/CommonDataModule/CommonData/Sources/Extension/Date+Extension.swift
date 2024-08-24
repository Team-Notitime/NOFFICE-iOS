//
//  Date+Extension.swift
//  CommonData
//
//  Created by DOYEON LEE on 7/31/24.
//

import Foundation

public extension Date {
    /// Convert date to formatted string
    ///
    /// Default format is "YYYY-MM-dd HH:mm:ss". If `includeWeekday` is true,
    /// the format will be "yyyy.MM.dd(E) HH:mm" where (E) is the weekday in Korean.
    ///
    /// - Parameter includeWeekday: A Boolean value that determines whether to include the weekday in the output string.
    /// - Returns: A formatted date string.
    func toString(includeWeekday: Bool = false) -> String {
        let dateFormatter = DateFormatter()
        if includeWeekday {
            dateFormatter.locale = Locale(identifier: "ko_KR")
            dateFormatter.dateFormat = "yyyy.MM.dd(E) HH:mm"
        } else {
            dateFormatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
        }
        return dateFormatter.string(from: self)
    }
}
