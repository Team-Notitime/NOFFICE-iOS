//
//  CompositionalReusableView.swift
//
//  Created by DOYEON LEE on 7/12/24.
//
//  Refer to MUMU
//

import UIKit

import SnapKit

public protocol CompositionalReusableView: UIView {
    associatedtype Section: CompositionalSection
    /**
     The identifier used when registering a cell in the collection view.
     By default, it uses the name of the implementation.
     */
    var reusableIdentifier: String { get }
    
    /// Configure the cell using the provided item of type ``CollectionViewItem``.
    ///
    /// - Parameter item: The item to configure the cell with.
    func configure(with section: Section)
}

public extension CompositionalReusableView {
    var reusableIdentifier: String {
        return String(describing: self)
    }
}

// MARK: - Helper component
public class EmptyReusableView: UICollectionReusableView, CompositionalReusableView {
    public typealias Section = EmptyCompositionalSection
    
    public var reusableIdentifier: String { return "EmptyReusableView" }
    
    public func configure(with section: EmptyCompositionalSection) { }
}

final class CollectionViewResuableViewContainer: UICollectionReusableView {
    enum ResuableViewType {
        case header, footer
    }
    
    private var currentView: (any CompositionalReusableView)?
    
    static var reusableIdentifier: String {
        return "\(type(of: self))"
    }
    
    func setContainedView(_ view: any CompositionalReusableView) {
        currentView?.removeFromSuperview()
        currentView = view
        addSubview(view)
        view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func configure<S: CompositionalSection>(with section: S, type: ResuableViewType) {
        switch type {
        case .header:
            guard let view = currentView as? S.Header else {
                fatalError("""
                            Failed to cast currentView to expected header type: \(S.Header.self).
                            """)
            }
            
            guard let section = section as? S.Header.Section else {
                fatalError("""
                            Failed to cast section to expected header section type: \(S.Header.Section.self).
                            """)
            }
            
            view.configure(with: section)
            
        case .footer:
            guard let view = currentView as? S.Footer else {
                fatalError("""
                            Failed to cast currentView to expected footer type: \(S.Footer.self).
                            """)
            }
            
            guard let section = section as? S.Footer.Section else {
                fatalError("""
                            Failed to cast section to expected footer section type: \(S.Footer.Section.self).
                            """)
            }
            
            view.configure(with: section)
        }
    }
}
