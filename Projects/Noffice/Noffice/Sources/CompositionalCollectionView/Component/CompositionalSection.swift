//
//  CollectionViewSection.swift
//  Noffice
//
//  Created by DOYEON LEE on 7/11/24.
//

import UIKit

/// The section of a collection view with a compositional layout.
public protocol CompositionalSection: Hashable {
    /// The data to be represented within the section.
    var items: [any CompositionalItem] { get }
    
    /// Configures the compositional layout for each section.
    var layout: NSCollectionLayoutSection { get }
    
    /// Hash value for the diffable data source.
    func hash(into hasher: inout Hasher)
}

public extension CompositionalSection {
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}

// MARK: - Helper component
/// A wrapper class for adding various sections to a single collection view.
public struct AnyCollectionViewSection: CompositionalSection {
    public var items: [any CompositionalItem]
    public var layout: NSCollectionLayoutSection
    
    private let _hashInto: (inout Hasher) -> Void
    
    public init<S: CompositionalSection>(_ section: S) {
        self.items = section.items
        self.layout = section.layout
        self._hashInto = section.hash
    }
    
    public func hash(into hasher: inout Hasher) {
        _hashInto(&hasher)
    }
}

extension CompositionalSection {
    public func asAnySection() -> AnyCollectionViewSection {
        return AnyCollectionViewSection(self)
    }
}
