//
//  CreateOrganizationConverter.swift
//  OrganizationData
//
//  Created by DOYEON LEE on 7/31/24.
//

import OrganizationEntity
import CommonData

@available(*, deprecated, message: "Openapi generate된 client로 대체")
struct CreateOrganizationConverter {
    static func convert(
        from response: BaseResponse<CreateOrganizationResponse>
    ) -> OrganizationEntity {
        return OrganizationEntity(
            id: response.data.id,
            name: response.data.name,
            categories: [],
            leader: 1,
            member: 0
        )
    }
    
    static func convert(
        from entity: NewOrganizationEntity
    ) -> CreateOrganizationRequest {
        return .init(
            name: entity.name,
            categories: entity.categories,
            profileImage: entity.imageURL,
            organizationEndAt: entity.endDate?.toString(),
            promotionCode: entity.promotionCode
        )
    }
}
