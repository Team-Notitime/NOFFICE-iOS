//
//  CollectionViewItemCell.swift
//  Noffice
//
//  Created by DOYEON LEE on 7/11/24.
//

import UIKit

// This is a UICollectionViewCell as it actually appears.
public protocol CollectionViewItemCell: UICollectionViewCell {
    associatedtype Item: CollectionViewItem
    
    /// Configure the cell using the provided item of type ``CollectionViewItem``.
    ///
    /// - Parameter item: The item to configure the cell with.
    func configure(with item: Item)
}
