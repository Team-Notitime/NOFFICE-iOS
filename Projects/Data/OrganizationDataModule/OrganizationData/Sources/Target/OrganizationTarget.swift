//
//  OrganizationTarget.swift
//  OrganizationData
//
//  Created by DOYEON LEE on 7/29/24.
//

import Foundation

import Moya

@available(*, deprecated, message: "Openapi generate client로 대체")
enum OrganizationTarget {
    case createOrganization(CreateOrganizationRequest)
    case getOrganization(id: Int)
    case joinOrganization(organizationId: Int, userId: Int)
    case getOrganizationList
}

@available(*, deprecated, message: "Openapi generate client로 대체")
extension OrganizationTarget: TargetType {
    var baseURL: URL {
        guard let urlString = Bundle.main.infoDictionary?["API_BASE_URL"] as? String,
              let url = URL(string: urlString) else {
            fatalError("API_BASE_URL not configured or invalid in Info.plist")
        }
        return url
    }

    var path: String {
        switch self {
        case .createOrganization:
            return "/organization"
            
        case let .getOrganization(id):
            return "/organization/\(id)"
            
        case let .joinOrganization(organizationId, _):
            return "/organization/\(organizationId)/join"
            
        case .getOrganizationList:
            return "/organization/list"
        }
    }

    var method: Moya.Method {
        switch self {
        case .createOrganization, .joinOrganization:
            return .post
            
        case .getOrganization, .getOrganizationList:
            return .get
        }
    }

    var sampleData: Data {
        return Data()
    }

    var task: Task {
        switch self {
        case .createOrganization(let dto):
            return .requestJSONEncodable(dto)
            
        case .joinOrganization(_, let userId):
            return .requestParameters(
                parameters: ["userId": userId],
                encoding: JSONEncoding.default
            )
            
        case .getOrganization, .getOrganizationList:
            return .requestPlain
        }
    }

    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
}
