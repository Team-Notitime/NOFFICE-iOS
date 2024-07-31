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
        entities: [OrganizationEntity],
        onTapNewButton: @escaping () -> Void,
        onTapOrganizationRow: @escaping (OrganizationEntity) -> Void
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
                        organizationName: organization.name
                    ) {
                        onTapOrganizationRow(organization)
                    }
                }
            )
        ]
        
        return sections
    }
}
