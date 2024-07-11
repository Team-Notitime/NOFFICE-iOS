//
//  CollectionViewSection.swift
//  Noffice
//
//  Created by DOYEON LEE on 7/11/24.
//

import UIKit

public protocol CollectionViewSection: Hashable { // TODO: Compositional prefix 붙이기
//    associatedtype Item: CollectionViewItem
    
    var items: [any CollectionViewItem] { get }
    var layout: NSCollectionLayoutSection { get }
    
    func hash(into hasher: inout Hasher)
}

public extension CollectionViewSection {
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}

public struct AnyCollectionViewSection: CollectionViewSection {
//    public typealias Item = AnyCollectionViewItem
    
    public var items: [any CollectionViewItem]
    public var layout: NSCollectionLayoutSection
    
    private let _hashInto: (inout Hasher) -> Void
    
    public init<S: CollectionViewSection>(_ section: S) {
        self.items = section.items
        self.layout = section.layout
        self._hashInto = section.hash
    }
    
    public func hash(into hasher: inout Hasher) {
        _hashInto(&hasher)
    }
}

extension CollectionViewSection {
    public func asAnySection() -> AnyCollectionViewSection {
        return AnyCollectionViewSection(self)
    }
}
