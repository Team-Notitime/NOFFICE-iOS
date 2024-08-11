//
//  GetOrganizationDTO.swift
//  OrganizationData
//
//  Created by DOYEON LEE on 7/31/24.
//

import OrganizationEntity
import CommonData

struct GetOrganizationConverter {
    static func convert(
        from response: BaseResponse<GetOrganizationResponse>
    ) -> OrganizationEntity {
        return OrganizationEntity(
            id: response.data.id,
            name: response.data.name,
            categories: response.data.categories,
            imageURL: response.data.profileImage,
            endDate: response.data.organizationEndAt?.toDate(),
            promotionCode: response.data.promotionCode,
            leader: response.data.leader,
            member: response.data.member
        )
    }
}
