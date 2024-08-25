//
//  OrganizationTabConverter.swift
//  OrganizationPresent
//
//  Created by DOYEON LEE on 7/31/24.
//

import DesignSystem
import OrganizationEntity

struct OrganizationTabConverter {
    static func convert(
        entities: [OrganizationSummaryEntity],
        onTapNewButton: @escaping () -> Void,
        onTapOrganizationRow: @escaping (OrganizationSummaryEntity) -> Void
    ) -> [any CompositionalSection] {
        let sections: [any CompositionalSection] = [
            NewOrganizationSection(
                items: [
                    NewOrganizationItem {
                        onTapNewButton()
                    }
                ]
            ),
            OrganizationSection(
                items: entities.map { organization in
                    OrganizationItem(
                        id: organization.id,
                        name: organization.name,
                        profileImageUrl: organization.profileImageUrl
                    ) {
                        onTapOrganizationRow(organization)
                    }
                }
            )
        ]
        
        return sections
    }
}
