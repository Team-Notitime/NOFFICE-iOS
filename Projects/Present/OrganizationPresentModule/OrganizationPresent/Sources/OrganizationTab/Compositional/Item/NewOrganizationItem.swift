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

final class NewOrganizationItem: CompositionalItem {
    typealias Cell = NewOrganizationAddItemCell
    
    // MARK: Event
    let onTapNewButton = PublishSubject<Void>()

    // MARK: DisposeBag
    let disposeBag = DisposeBag()
    
    init() { }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(String(describing: type(of: self)))
    }
}

final class NewOrganizationAddItemCell: UIView, CompositionalItemCell {
    // MARK: UI Component
    lazy var newButton = BaseButton(
        contentsBuilder: {
            [
                UILabel().then {
                    $0.text = "새로운 그룹"
                    $0.setTypo(.body1b)
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
        addSubview(newButton)
        
        newButton.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func configure(with item: NewOrganizationItem) {
        // action binding
        newButton.onTap
            .bind(to: item.onTapNewButton)
            .disposed(by: disposeBag)
    }
}
