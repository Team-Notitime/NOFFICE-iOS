//
//  CollectionViewItem.swift
//  Noffice
//
//  Created by DOYEON LEE on 7/11/24.
//

import Foundation

// This is a just data container for UICollectionViewCell and DiffableDataSource
public protocol CollectionViewItem: Hashable {
    associatedtype Cell: CollectionViewItemCell
    
    /// Identifier for registering the cell in the collection view.
    var reusableIdentifier: String { get }
    
    /// Method to inject data into the cell. Call the configure(with:) method of the cell passed as an argument.
    ///
    /// - Note: A default implementation is provided, so there is no need to implement this method unless customization is required.
    ///   ```swift
    ///       func configureCell(cell: inout Cell) {
    ///           cell.configure(with: self)
    ///       }
    ///   ```
    func configureCell(cell: inout Cell)
    
    /// Hash value for detecting changes in the diffable datasource.
    ///
    /// Implement this function to add additional values that should be combined into the hash.
    func hash(into hasher: inout Hasher)
    
    var cellType: Cell.Type { get } 
}

public extension CollectionViewItem {
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
    func configureCell(cell: inout Cell) {
        if let self = self as? Cell.Item {
            cell.configure(with: self)
        } else {
            fatalError(
                """
                The Cell type of the CollectionViewItem (\(type(of: self))) 
                and the Item type of the CollectionViewItemCell (\(Cell.Item.self)) must match.
                """)
        }
    }
    
    
}

struct CollectionViewItemWrapper: Hashable {
    let wrappee: any CollectionViewItem
    
    static func == (lhs: CollectionViewItemWrapper, rhs: CollectionViewItemWrapper) -> Bool {
        lhs.wrappee.hashValue == rhs.wrappee.hashValue
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(wrappee.hashValue)
    }
}
