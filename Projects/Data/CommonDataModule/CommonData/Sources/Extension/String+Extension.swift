//
//  String+Extension.swift
//  CommonData
//
//  Created by DOYEON LEE on 7/31/24.
//

import Foundation

public extension String {
    /// Convert string to Date using the default format
    ///
    /// Default format is "yyyy-MM-dd HH:mm:ss"
    func toDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter.date(from: self)
    }
}
