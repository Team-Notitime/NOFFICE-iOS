//
//  CompositionalLayout+Extension.swift
//  Noffice
//
//  Created by DOYEON LEE on 7/12/24.
//

import UIKit

extension CompositionalLayout {
    /// Make the `NSCollectionLayoutSection`
    func makeSectionLayout() -> NSCollectionLayoutSection {
        let group = createGroup(from: groupLayout)

        // Create the section and configure its properties
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = sectionInset
        section.orthogonalScrollingBehavior = scrollBehavior
        section.interGroupSpacing = groupLayout.groupSpacing

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
    
    private func createGroup(from layout: CompositionalGroupLayout) -> NSCollectionLayoutGroup {
        let items: [NSCollectionLayoutItem] = layout.items.map { item in
            switch item {
            case .item(let size):
                let layoutSize = NSCollectionLayoutSize(
                    widthDimension: size.width,
                    heightDimension: size.height
                )
                return NSCollectionLayoutItem(layoutSize: layoutSize)
                
            case .group(let groupLayout):
                return createGroup(from: groupLayout)
            }
        }
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: layout.size.width,
            heightDimension: layout.size.height
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: items
        )
        group.interItemSpacing = .fixed(layout.itemSpacing)
        
        return group
    }
}
