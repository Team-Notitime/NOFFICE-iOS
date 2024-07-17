//
//  OrganizationAddItem.swift
//  OrganizationPresent
//
//  Created by DOYEON LEE on 7/17/24.
//

import UIKit

import DesignSystem
import Assets

import RxSwift

final class OrganizationAddItem: CompositionalItem {
    typealias Cell = OrganizationAddItemCell
    
    // MARK: Event
    let onTapAddButton = PublishSubject<Void>()

    // MARK: DisposeBag
    let disposeBag = DisposeBag()
    
    init() { }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(String(describing: type(of: self)))
    }
}

final class OrganizationAddItemCell: UIView, CompositionalItemCell {
    // MARK: UI Component
    lazy var addButton = BaseButton(
        contentsBuilder: {
            [
                UILabel().then {
                    $0.text = "새로운 그룹"
                },
                UIImageView(image: .iconPlus).then {
                    $0.contentMode = .scaleAspectFit
                }
            ]
            
        }
    ).then {
        $0.styled(variant: .translucent, color: .green, size: .medium)
    }
    
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
        addSubview(addButton)
        
        addButton.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func configure(with item: OrganizationAddItem) {
        // bind action
        addButton.onTap
            .bind(to: item.onTapAddButton)
            .disposed(by: disposeBag)
    }
}
