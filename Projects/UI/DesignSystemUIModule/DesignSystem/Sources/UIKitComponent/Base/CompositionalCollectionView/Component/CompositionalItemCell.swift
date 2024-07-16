//
//  CollectionViewItemCell.swift
//
//  Created by DOYEON LEE on 7/11/24.
//
//  Refer to MUMU
//

import UIKit

import SnapKit

/// This is a UICollectionViewCell as it actually appears.
public protocol CompositionalItemCell: UIView {
    associatedtype Item: CompositionalItem
    
    /// Configure the cell using the provided item of type ``CollectionViewItem``.
    ///
    /// - Parameter item: The item to configure the cell with.
    func configure(with item: Item)
    
    var itemType: Item.Type { get }
}

public extension CompositionalItemCell {
    var itemType: Item.Type { return Item.self }
}

// MARK: - Helper component
/// The only cell registered in the collection view.
///
/// To accommodate various CompositionalItemCells, 
/// the actual cell content is laid out as a UIView within this container.
final class CollectionViewItemCellContainer: UICollectionViewCell {
    private var currentCell: (any CompositionalItemCell)?
    
    static var reusableIdentifier: String {
        return "\(type(of: self))"
    }
    
    func setContainedCell(_ cell: any CompositionalItemCell) {
        currentCell?.removeFromSuperview()
        currentCell = cell
        contentView.addSubview(cell)
        cell.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func configure<T: CompositionalItem>(with item: T) {
        guard let cell = currentCell as? T.Cell else {
            fatalError("Invalid cell type for item: \(item)")
        }
        
        guard let item = item as? T.Cell.Item else {
            fatalError("Invalid item type for cell: \(cell)")
        }
        
        cell.configure(with: item)
        
        if let cell = cell as? T.Cell.Item.Cell {
            item.bind(cell: cell)
        }
    }
}
