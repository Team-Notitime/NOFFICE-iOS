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
    let onTap: () -> Void
    
    // MARK: Data
    let organizationName: String

    // MARK: DisposeBag
    let disposeBag = DisposeBag()
    
    // MARK: Initializer
    init(
        organizationName: String,
        onTap: @escaping () -> Void
    ) {
        self.organizationName = organizationName
        self.onTap = onTap
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(String(describing: type(of: self)))
        hasher.combine(organizationName)
    }
}

final class OrganizationItemCell: UIView, CompositionalItemCell {
    // MARK: UI Component
    lazy var organizationRow = NofficeOrganizationRow()
    
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
        organizationRow.onTap
            .subscribe(onNext: {
                item.onTap()
            })
            .disposed(by: disposeBag)
    }
}
