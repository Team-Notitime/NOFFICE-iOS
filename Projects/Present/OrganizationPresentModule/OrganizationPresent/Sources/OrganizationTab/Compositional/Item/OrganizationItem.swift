//
//  OrganizationItem.swift
//  OrganizationPresent
//
//  Created by DOYEON LEE on 7/17/24.
//

import UIKit

import DesignSystem
import Assets

import RxSwift
import RxGesture

final class OrganizationItem: CompositionalItem {
    typealias Cell = OrganizationItemCell
    
    // MARK: Event
    let onTap = PublishSubject<Void>()
    
    // MARK: Data
    let organizationName: String

    // MARK: DisposeBag
    let disposeBag = DisposeBag()
    
    // MARK: Initializer
    init(organizationName: String) {
        self.organizationName = organizationName
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(String(describing: type(of: self)))
        hasher.combine(organizationName)
    }
}

final class OrganizationItemCell: UIView, CompositionalItemCell {
    // MARK: UI Component
    lazy var organizationRow = OrganizationRow()
    
    // MARK: DisposeBag
    private let disposeBag = DisposeBag()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    private func setup() {
        addSubview(organizationRow)
        
        organizationRow.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func configure(with item: OrganizationItem) {
        // - Binding data
        organizationRow.organizationName = item.organizationName
                
        // - Binding action
        self.organizationRow.onTap
            .bind(to: item.onTap)
            .disposed(by: disposeBag)
    }
}
