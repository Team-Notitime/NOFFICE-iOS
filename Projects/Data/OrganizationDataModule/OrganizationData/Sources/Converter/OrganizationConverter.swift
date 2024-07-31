//
//  OrganizationConverter.swift
//  OrganizationData
//
//  Created by DOYEON LEE on 7/31/24.
//

import OrganizationEntity
import CommonData

struct OrganizationConverter {
    static func convert(
        from response: BaseResponse<Organization>
    ) -> OrganizationEntity {
        return OrganizationEntity(
            id: response.data.id,
            name: response.data.name,
            categories: []
        )
    }
}
