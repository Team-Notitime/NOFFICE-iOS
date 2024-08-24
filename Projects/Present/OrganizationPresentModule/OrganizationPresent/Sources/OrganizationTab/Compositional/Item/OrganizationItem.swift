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
    let name: String
    
    let profileImageUrl: URL?

    // MARK: DisposeBag
    let disposeBag = DisposeBag()
    
    // MARK: Initializer
    init(
        name: String,
        profileImageUrl: URL?,
        onTap: @escaping () -> Void
    ) {
        self.name = name
        self.profileImageUrl = profileImageUrl
        self.onTap = onTap
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(String(describing: type(of: self)))
        hasher.combine(name)
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
        organizationRow.organizationName = item.name
        
        organizationRow.organizationImageUrl = item.profileImageUrl
        
        // - Binding action
        organizationRow.onTap
            .subscribe(onNext: {
                item.onTap()
            })
            .disposed(by: disposeBag)
    }
}
