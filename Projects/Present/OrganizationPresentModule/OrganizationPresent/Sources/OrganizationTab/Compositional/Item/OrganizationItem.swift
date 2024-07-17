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
    // MARK: UIConstant
    private let padding: CGFloat = 16
    private let imageSize: CGFloat = 48
    
    // MARK: UI Component
    lazy var organizationImage = UIImageView(image: .imgProfileGroup).then {
        $0.setSize(width: imageSize, height: imageSize)
        $0.contentMode = .scaleToFill
        $0.clipsToBounds = true
    }
    
    lazy var organizationNameLabel = UILabel().then {
        $0.setTypo(.body1b)
        $0.textColor = .grey800
    }
    
    lazy var moreIcon = UIImageView(image: .iconChevronRight).then {
        $0.tintColor = .grey400
        $0.contentMode = .scaleAspectFit
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
        addSubview(organizationImage)
        addSubview(organizationNameLabel)
        addSubview(moreIcon)
        
        organizationImage.snp.makeConstraints {
            $0.top.bottom.left.equalToSuperview().inset(padding)
        }
        
        organizationNameLabel.snp.makeConstraints {
            $0.left.equalTo(organizationImage.snp.right).offset(padding)
            $0.centerY.equalTo(organizationImage.snp.centerY)
        }
        
        moreIcon.snp.makeConstraints {
            $0.right.equalToSuperview().inset(padding)
            $0.centerY.equalTo(organizationImage.snp.centerY)
        }
    }
    
    func configure(with item: OrganizationItem) {
        // data binding
        organizationNameLabel.text = item.organizationName
                
        // action binding
        self.rx.tapGesture()
            .when(.recognized)
            .map { _ in }
            .bind(to: item.onTap)
            .disposed(by: disposeBag)
    }
}
