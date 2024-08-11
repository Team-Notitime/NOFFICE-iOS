//
//  AnnouncementTarget.swift
//  AnnouncementData
//
//  Created by DOYEON LEE on 7/31/24.
//

import Foundation

import Moya

enum AnnouncementTarget {
    case createAnnouncement
    case getAllAnnouncement
    case joinOrganization(organizationId: Int, userId: Int)
    case getOrganizationList
}

extension AnnouncementTarget: TargetType {
    var baseURL: URL {
        guard let urlString = Bundle.main.infoDictionary?["API_BASE_URL"] as? String,
              let url = URL(string: urlString) else {
            fatalError("API_BASE_URL not configured or invalid in Info.plist")
        }
        return url
    }

    var path: String {
        switch self {
        case .createAnnouncement:
            return "/organization"
            
        case let .getAllAnnouncement:
            return "/organization"
            
        case let .joinOrganization(organizationId, _):
            return "/organization/\(organizationId)/join"
            
        case .getOrganizationList:
            return "/organization/list"
        }
    }

    var method: Moya.Method {
        switch self {
        case .createAnnouncement, .joinOrganization:
            return .post
            
        case .getAllAnnouncement, .getOrganizationList:
            return .get
        }
    }

    var sampleData: Data {
        return Data()
    }

    var task: Task {
        switch self {
        case .createAnnouncement:
            return .requestPlain
            
        case .joinOrganization(_, let userId):
            return .requestParameters(
                parameters: ["userId": userId],
                encoding: JSONEncoding.default
            )
            
        case .getAllAnnouncement, .getOrganizationList:
            return .requestPlain
        }
    }

    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
}
