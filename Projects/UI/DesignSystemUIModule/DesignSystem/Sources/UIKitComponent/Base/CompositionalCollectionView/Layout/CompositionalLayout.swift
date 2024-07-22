//
//  CompositionalLayout.swift
//  Noffice
//
//  Created by DOYEON LEE on 7/12/24.
//

import UIKit

/**
 Helper for create compositonal layout
 
 Use like this
 ```swift
 struct Section: CompositionalSection {
     var layout: CompositionalLayout = .init(
         groupLayout: .init(
             size: .init(width: .fractionalWidth(1.0), height: .absolute(100))),
             items: [
                 .item(size: .init(width: .fractionalWidth(0.7), height: .absolute(100)),
                 .item(size: .init(width: .fractionalWidth(0.3), height: .absolute(100)))
             ],
             spacing: 8
         ),
         sectionInset: .init(top: 12, leading: 12, bottom: 12, trailing: 12)
     )
 // ...
 ```
 */

public struct CompositionalLayout {
    let groupLayout: CompositionalGroupLayout
    
    var headerSize: CompositionalSize?
    var footerSize: CompositionalSize?
    
    let sectionInset: NSDirectionalEdgeInsets
    
    var scrollBehavior: UICollectionLayoutSectionOrthogonalScrollingBehavior
    
    public init(
        groupLayout: CompositionalGroupLayout,
        headerSize: CompositionalSize? = nil,
        footerSize: CompositionalSize? = nil,
        sectionInset: NSDirectionalEdgeInsets,
        scrollBehavior: UICollectionLayoutSectionOrthogonalScrollingBehavior = .continuous
    ) {
        self.groupLayout = groupLayout
        self.headerSize = headerSize
        self.footerSize = footerSize
        self.sectionInset = sectionInset
        self.scrollBehavior = scrollBehavior
    }
}

public struct CompositionalGroupLayout {
    let size: CompositionalSize
    let groupSpacing: CGFloat
    
    let items: [CompositionalItemLayout]
    let itemSpacing: CGFloat

    public init(
        size: CompositionalSize,
        groupSpacing: CGFloat,
        items: [CompositionalItemLayout],
        itemSpacing: CGFloat
    ) {
        self.size = size
        self.groupSpacing = groupSpacing
        self.items = items
        self.itemSpacing = itemSpacing
    }
}

public struct CompositionalSize {
    let width: NSCollectionLayoutDimension
    let height: NSCollectionLayoutDimension
    
    public init(
        width: NSCollectionLayoutDimension,
        height: NSCollectionLayoutDimension
    ) {
        self.width = width
        self.height = height
    }
}

public enum CompositionalItemLayout {
    case item(size: CompositionalSize)
    case group(layout: CompositionalGroupLayout)
}
