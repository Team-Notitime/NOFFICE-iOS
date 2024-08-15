//
//  JoinOrganizationConverter.swift
//  OrganizationData
//
//  Created by DOYEON LEE on 7/31/24.
//

import OrganizationEntity
import CommonData

@available(*, deprecated, message: "Openapi generate된 client로 대체")
struct JoinOrganizationConverter {
    static func convert(
        from response: BaseResponse<JoinOrganizationResponse>
    ) -> Bool {
        return response.data.isSuccess
    }
}
