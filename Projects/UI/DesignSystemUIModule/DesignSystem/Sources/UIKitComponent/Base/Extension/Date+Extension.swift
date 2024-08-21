//
//  Date+Extension.swift
//  DesignSystemApp
//
//  Created by DOYEON LEE on 7/20/24.
//

import Foundation

public extension Date {
    func toString(format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}
