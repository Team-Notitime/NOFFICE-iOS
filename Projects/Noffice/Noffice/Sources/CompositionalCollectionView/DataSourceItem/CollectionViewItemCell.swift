//
//  CollectionViewItemCell.swift
//  Noffice
//
//  Created by DOYEON LEE on 7/11/24.
//

import UIKit

// This is a UICollectionViewCell as it actually appears.
public protocol CollectionViewItemCell: UIView {
    associatedtype Item: CollectionViewItem
    
    /// Configure the cell using the provided item of type ``CollectionViewItem``.
    ///
    /// - Parameter item: The item to configure the cell with.
    func configure(with item: Item)
}

final class CollectionViewItemCellContainer: UICollectionViewCell {
    private var currentCell: (any CollectionViewItemCell)?
    
    static var reusableIdentifier: String {
        return "\(type(of: self))"
    }
    
    func setContainedCell(_ cell: any CollectionViewItemCell) {
        currentCell?.removeFromSuperview()
        currentCell = cell
        contentView.addSubview(cell)
        cell.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func configure<T: CollectionViewItem>(with item: T) {
        guard let cell = currentCell as? T.Cell else {
            fatalError("Invalid cell type for item: \(item)")
        }
        
        guard let item = item as? T.Cell.Item else {
            fatalError("Invalid item type for cell: \(cell)")
        }
        
        cell.configure(with: item)
    }
}
