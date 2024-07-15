//
//  CompositionalLayout+Extension.swift
//  Noffice
//
//  Created by DOYEON LEE on 7/12/24.
//

import UIKit

extension CompositionalLayout {
    /// Make  the `NSCollectionLayoutSection`
    func makeSectionLayout() -> NSCollectionLayoutSection {
        // Create the item sizes and items
        let items: [NSCollectionLayoutItem] = groupLayout.items.map { itemSize in
            let layoutSize = NSCollectionLayoutSize(
                widthDimension: itemSize.width,
                heightDimension: itemSize.height
            )
            let item = NSCollectionLayoutItem(layoutSize: layoutSize)
            return item
        }

        // Create the group size and group
        let groupSize = NSCollectionLayoutSize(
            widthDimension: groupLayout.size.width,
            heightDimension: groupLayout.size.height
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: items
        )
        group.interItemSpacing = .fixed(groupLayout.spacing)

        // Create the section and configure its properties
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = sectionInset
        section.orthogonalScrollingBehavior = scrollBehavior

        // Configure header if available
        if let headerSize = headerSize {
            let headerItemSize = NSCollectionLayoutSize(
                widthDimension: headerSize.width,
                heightDimension: headerSize.height
            )
            let headerItem = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: headerItemSize,
                elementKind: UICollectionView.elementKindSectionHeader,
                alignment: .top
            )
            section.boundarySupplementaryItems.append(headerItem)
        }

        // Configure footer if available
        if let footerSize = footerSize {
            let footerItemSize = NSCollectionLayoutSize(
                widthDimension: footerSize.width,
                heightDimension: footerSize.height
            )
            let footerItem = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: footerItemSize,
                elementKind: UICollectionView.elementKindSectionFooter,
                alignment: .bottom
            )
            section.boundarySupplementaryItems.append(footerItem)
        }

        return section
    }
}
