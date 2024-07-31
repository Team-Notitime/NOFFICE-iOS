//
//  Date+Extension.swift
//  CommonData
//
//  Created by DOYEON LEE on 7/31/24.
//

import Foundation

public extension Date {
    /// Convert date to default format string
    ///
    /// Default format is "YYYY-MM-dd HH:mm:ss"
    func toString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
        return dateFormatter.string(from: self)
    }
}
