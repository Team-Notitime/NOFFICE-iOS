//
//  CompositionalReusableView.swift
//  Noffice
//
//  Created by DOYEON LEE on 7/12/24.
//

import UIKit

public protocol CompositionalReusableView: UIView {
    associatedtype Section: CompositionalSection
    var reusableIdentifier: String { get }
    func configure(with section: Section)
}

// MARK: - Helper
// Type erased header and footer
//public struct AnyCompositionalReusableView {
//    private let _configure: (any CompositionalSection) -> Void
//    let reusableIdentifier: String
//    
//    init<V: CompositionalReusableView>(_ view: V) {
//        self.reusableIdentifier = view.reusableIdentifier
//        self._configure = { section in
//            if let section = section as? V.Section {
//                view.configure(section: section)
//            } else {
//                fatalError("Invalid section type for reusable view")
//            }
//        }
//    }
//    
//    func configure(section: any CompositionalSection) {
//        _configure(section)
//    }
//}
//
//extension CompositionalReusableView {
//    public func asAnyReusableView() -> AnyCompositionalReusableView {
//        return AnyCompositionalReusableView(self)
//    }
//}

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

