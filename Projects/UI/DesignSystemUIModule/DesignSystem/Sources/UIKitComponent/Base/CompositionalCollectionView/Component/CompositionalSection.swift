//
//  CollectionViewSection.swift
//
//  Created by DOYEON LEE on 7/11/24.
//
//  Refer to MUMU
//

import UIKit

/// The section of a collection view with a compositional layout.
public protocol CompositionalSection: Hashable {
    associatedtype Header: CompositionalReusableView = EmptyReusableView
    associatedtype Footer: CompositionalReusableView = EmptyReusableView
    
    /// The data to be represented within the section.
    var items: [any CompositionalItem] { get }
    
    /// Configures the compositional layout for each section.
    var layout: CompositionalLayout { get }
    
    /// Hash value for the diffable data source.
    func hash(into hasher: inout Hasher)
    
    var headerType: Header.Type { get }
    var footerType: Footer.Type { get }
}

public extension CompositionalSection {
    var headerType: Header.Type { return Header.self }
    var footerType: Footer.Type { return Footer.self }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}

// MARK: - Helper component
public struct EmptyCompositionalSection: CompositionalSection {
    public typealias Header = EmptyReusableView
    public typealias Footer = EmptyReusableView
    
    public var items: [any CompositionalItem]
    public var layout: CompositionalLayout
    
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

/**
 A wrapper class for adding various sections to a single collection view.
 
```swift
 let collectionView = CompositionalCollectionView()
 
 let sectionsSubject = BehaviorSubject<[AnyCompositionalSection]>(value: sections)
 
 collectionView.bindSections(
     by: sectionsSubject.asObservable()
 )
 .disposed(by: disposeBag)
 
 let sections = [
    Section(
         items: [ ... ]
     ).asAnySection()
 ]

 self.sectionsSubject.onNext(sections)
 ```
*/

public struct CompositionalSectionWrapper: Hashable {
    let wrappee: any CompositionalSection
    
    public static func == (lhs: CompositionalSectionWrapper, rhs: CompositionalSectionWrapper) -> Bool {
        lhs.wrappee.hashValue == rhs.wrappee.hashValue
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(wrappee.hashValue)
    }
}

// public struct AnyCompositionalSection: CompositionalSection {
//    public var items: [any CompositionalItem]
//    public var layout: CompositionalLayout
//    
//    private let _sectionType: any CompositionalSection.Type
//    private let _hashInto: (inout Hasher) -> Void
//    
//    public init<S: CompositionalSection>(_ section: S) {
//        self.items = section.items
//        self.layout = section.layout
//        self._hashInto = section.hash
//    }
//    
//    public func hash(into hasher: inout Hasher) {
//        _hashInto(&hasher)
//    }
//    
//    public var headerType: Header.Type {
//        return _sectionType.Header.self
//    }
//    
//    var footerType: Footer.Type {
//        
//    }
// }

// extension CompositionalSection {
    /**
     It is a helper method for using AnyCompositionalSection
     
    ```swift
     let collectionView = CompositionalCollectionView()
     
     let sectionsSubject = BehaviorSubject<[AnyCompositionalSection]>(value: sections)
     
     collectionView.bindSections(
         by: sectionsSubject.asObservable()
     )
     .disposed(by: disposeBag)
     
     let sections = [
        Section(
             items: [ ... ]
         ).asAnySection() // ✅
     ]
 
     self.sectionsSubject.onNext(sections)
     ```
     */
//    public func asAnySection() -> AnyCompositionalSection {
//        return AnyCompositionalSection(self)
//    }
// }
