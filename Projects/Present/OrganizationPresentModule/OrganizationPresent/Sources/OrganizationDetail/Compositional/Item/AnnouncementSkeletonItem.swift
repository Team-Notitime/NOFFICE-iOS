//
//  AnnouncementSkeletonItem.swift
//  OrganizationPresent
//
//  Created by DOYEON LEE on 8/1/24.
//

import UIKit

import DesignSystem
import Assets

import RxSwift
import SkeletonView

final class AnnouncementSkeletonItem: CompositionalItem {
    typealias Cell = AnnouncementSkeletonItemCell
    
    // MARK: Data
    let id: Int = UUID().hashValue
    
    init() { }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

final class AnnouncementSkeletonItemCell: UIView, CompositionalItemCell {
    private static let BadgeIconSize: CGFloat = 15
    
    private static let BadgeLabelTypo: Typo = .body2b
    
    // MARK: UI Component
    // - Stack view
    lazy var stackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = GlobalViewConstant.SpacingUnit * 2
    }
    
    // - Title
    private lazy var titleLabel = UILabel().then {
        $0.setTypo(.body0b)
        $0.numberOfLines = 1
        $0.textColor = .grey800
    }
    
    // - Badge stack view
    private lazy var badgeStackView = BaseHStack(alignment: .leading) {
        [
            BaseSpacer()
        ]
    }
    
    // - Body
    private lazy var bodyLabel = UILabel().then {
        $0.setTypo(.body2)
        $0.numberOfLines = 2
        $0.textColor = .grey600
    }
    
    private lazy var createdDateLabel = UILabel().then {
        $0.setTypo(.body3)
        $0.textColor = .grey400
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
        backgroundColor = .fullWhite
        layer.cornerRadius = RoundedConstant.Xlarge
        layer.masksToBounds = true
        
        addSubview(stackView)
        
        stackView.addArrangedSubview(titleLabel)
        
        stackView.addArrangedSubview(badgeStackView)
        
        stackView.addArrangedSubview(bodyLabel)
        
        stackView.addArrangedSubview(createdDateLabel)
        
        stackView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
                .inset(20)
            $0.left.right.equalToSuperview()
                .inset(10)
        }
        
        setupSkeleton()
    }
    
    func configure(with item: AnnouncementSkeletonItem) { }
    
    private func setupSkeleton() {
        // Set isSkeletonable
        stackView.isSkeletonable = true
        
        titleLabel.isSkeletonable = true
        titleLabel.skeletonTextLineHeight = .relativeToFont
        titleLabel.linesCornerRadius = SkeletonConstant.LineCornerRadius
        
        badgeStackView.isSkeletonable = true
        badgeStackView.skeletonCornerRadius = Float(SkeletonConstant.LineCornerRadius)
        
        bodyLabel.isSkeletonable = true
        bodyLabel.skeletonTextLineHeight = .relativeToFont
        bodyLabel.linesCornerRadius = SkeletonConstant.LineCornerRadius
        
        createdDateLabel.isSkeletonable = true
        createdDateLabel.skeletonTextLineHeight = .relativeToFont
        createdDateLabel.linesCornerRadius = SkeletonConstant.LineCornerRadius
        
        // Start skeleton animation
        DispatchQueue.main.async { [weak self] in
            self?.stackView.showAnimatedGradientSkeleton()
            
            self?.titleLabel.text = "Skeleton dummy"
            
            self?.bodyLabel.text = "Skeleton dummy \n \n"
            
            self?.createdDateLabel.text = "Skeleton dummy"
        }
    }
}
