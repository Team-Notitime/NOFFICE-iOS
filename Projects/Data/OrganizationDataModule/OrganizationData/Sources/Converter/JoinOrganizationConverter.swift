//
//  JoinOrganizationConverter.swift
//  OrganizationData
//
//  Created by DOYEON LEE on 7/31/24.
//

import OrganizationEntity
import CommonData

struct JoinOrganizationConverter {
    static func convert(
        from response: BaseResponse<JoinOrganizationResponse>
    ) -> Bool {
        return response.data.isSuccess
    }
}
