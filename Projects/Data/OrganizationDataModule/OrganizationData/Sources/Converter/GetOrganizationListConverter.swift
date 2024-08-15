//
//  GetOrganizationListConverter.swift
//  OrganizationData
//
//  Created by DOYEON LEE on 7/31/24.
//

import OrganizationEntity
import CommonData

@available(*, deprecated, message: "Openapi generate된 client로 대체")
struct GetOrganizationListConverter {
    static func convert(
        from response: BaseResponse<GetOrganizationListResponse>
    ) -> [OrganizationEntity] {
        return response.data.organizations.map {
            OrganizationEntity(
                id: $0.id,
                name: $0.name,
                categories: $0.categories,
                imageURL: $0.profileImage,
                endDate: $0.organizationEndAt?.toDate(),
                promotionCode: $0.promotionCode,
                leader: $0.leader,
                member: $0.member
            )
        }
    }
}
