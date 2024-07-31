//
//  CreateOrganizationConverter.swift
//  OrganizationData
//
//  Created by DOYEON LEE on 7/31/24.
//

import OrganizationEntity
import CommonData

struct CreateOrganizationConverter {
    static func convert(
        from response: BaseResponse<CreateOrganizationDTO.Response>
    ) -> OrganizationEntity {
        return OrganizationEntity(
            id: response.data.id,
            name: response.data.name,
            categories: []
        )
    }
    
    static func convert(
        from entity: OrganizationEntity
    ) -> CreateOrganizationDTO.Request {
        return .init(
            name: entity.name,
            categories: entity.categories,
            profileImage: entity.imageURL,
            organizationEndAt: entity.endDate?.toString(),
            promotionCode: entity.promotionCode
        )
    }
}
