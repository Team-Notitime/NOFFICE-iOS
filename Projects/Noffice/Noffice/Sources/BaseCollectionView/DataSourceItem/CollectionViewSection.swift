//
//  CollectionViewSection.swift
//  Noffice
//
//  Created by DOYEON LEE on 7/11/24.
//

import UIKit

public protocol CollectionViewSection: Hashable { // TODO: Compositional prefix 붙이기
    associatedtype Item: CollectionViewItem
    
    var reusableIdentifier: String { get }
    var items: [Item] { get }
    var layout: UICollectionViewCompositionalLayout { get }
    
    func hash(into hasher: inout Hasher)
}

public extension CollectionViewSection {
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}
