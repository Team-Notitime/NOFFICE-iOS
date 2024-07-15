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
             size: .init(width: .fractionalWidth(1.0), height: .absolute(100)),
             items: [
                 .init(width: .fractionalWidth(0.7), height: .absolute(100)),
                 .init(width: .fractionalWidth(0.3), height: .absolute(100))
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
    
    var scrollBehavior: UICollectionLayoutSectionOrthogonalScrollingBehavior = .continuous
    
    public init(
        groupLayout: CompositionalGroupLayout,
        headerSize: CompositionalSize? = nil,
        footerSize: CompositionalSize? = nil,
        sectionInset: NSDirectionalEdgeInsets,
        scrollBehavior: UICollectionLayoutSectionOrthogonalScrollingBehavior
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
    let items: [CompositionalSize]
    let spacing: CGFloat
    
    public init(
        size: CompositionalSize,
        items: [CompositionalSize],
        spacing: CGFloat
    ) {
        self.size = size
        self.items = items
        self.spacing = spacing
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
