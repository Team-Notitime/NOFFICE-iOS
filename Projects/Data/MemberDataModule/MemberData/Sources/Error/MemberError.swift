//
//  MemberError.swift
//  MemberData
//
//  Created by DOYEON LEE on 8/12/24.
//

import Foundation

public enum MemberError: LocalizedError {
    case invalidResponse
    case underlying(Error)
}
