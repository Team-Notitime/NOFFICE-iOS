//
//  CollectionViewItem.swift
//
//  Created by DOYEON LEE on 7/11/24.
//
//  Refer to MUMU
//

import Foundation

/// This is a data container for UICollectionViewCell and DiffableDataSource
public protocol CompositionalItem: Hashable {
    associatedtype Cell: CompositionalItemCell
    
    /**
     Hash value for detecting changes in the diffable datasource.
     
     Implement this function to add additional values that should be combined into the hash.
     */
    func hash(into hasher: inout Hasher)
    
    /**
     The UICollectionViewCell type that corresponds to CollectionViewItem.
     
     Used to configure the cell in the datasource when the cell is dequeued.
     
     - example:
     ```swift
     var cellType: ItemConcrete.Type {
        return ItemConcrete.self
     }
     ```
     */
    var cellType: Cell.Type { get }
}

public extension CompositionalItem {
    var cellType: Cell.Type { return Cell.self }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
    var reusableIdentifier: String {
        return String(describing: self)
    }
}

// MARK: - Helper component
/// A wrapper class for storing various CompositionalItems in the diffable data source.
struct CollectionViewItemWrapper: Hashable {
    let wrappee: any CompositionalItem
    
    static func == (lhs: CollectionViewItemWrapper, rhs: CollectionViewItemWrapper) -> Bool {
        lhs.wrappee.hashValue == rhs.wrappee.hashValue
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(wrappee.hashValue)
    }
}
