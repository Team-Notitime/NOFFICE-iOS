//
//  BaseResponse.swift
//  CommonData
//
//  Created by DOYEON LEE on 7/29/24.
//

import Foundation

public struct BaseResponse<T: Codable>: Codable {
    public let timestamp: String
    public let httpStatus: Int
    public let code: String
    public let message: String
    public let data: T
    
    public init(
        timestamp: String,
        httpStatus: Int,
        code: String,
        message: String,
        data: T
    ) {
        self.timestamp = timestamp
        self.httpStatus = httpStatus
        self.code = code
        self.message = message
        self.data = data
    }
}
