//
//  BadgeBookViewController.swift
//  DesignSystemApp
//
//  Created by DOYEON LEE on 7/14/24.
//

import UIKit

import DesignSystem
import Assets

import RxSwift
import RxCocoa
import Then
import SnapKit

final class BadgeBookViewController: UIViewController {
    // MARK: UI Component
    private lazy var scrollView = UIScrollView()
    
    private lazy var contentView = UIView()
    
    private lazy var stackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 8
        $0.alignment = .center
        $0.distribution = .fill
    }
    
    private lazy var variantControlLabel = UILabel().then {
        $0.text = "Variant"
        $0.setTypo(.body2)
    }
    
    private lazy var variantControl = UISegmentedControl(
        items: BasicBadgeVariant.allCases.map { $0.rawValue }
    ).then {
        $0.selectedSegmentIndex = 0
    }
    
    private lazy var badgeLabels: [UILabel] = BasicBadgeColor.allCases.map { color in
        UILabel().then {
            $0.text = color.rawValue
            $0.setTypo(.body3)
            $0.textColor = .grey400
        }
    }
    
    private lazy var badges: [BaseBadge] = BasicBadgeColor.allCases.map { color in
        BaseBadge(contentsBudiler: {
            [
                UILabel().then {
                    $0.text = "badge"
                    $0.setTypo(.body1b)
                }
            ]
        }).then {
            $0.styled(color: color)
        }
    }
    
    private lazy var badgeWithIconLabel = UILabel().then {
        $0.text = "With icon"
        $0.setTypo(.body1b)
    }
    
    private lazy var badgeWithIcon = BaseBadge(contentsBudiler: {
        [
            UILabel().then {
                $0.text = "badge"
                $0.setTypo(.body1b)
            },
            UIImageView(image: .iconCheck)
        ]
    }).then {
        $0.styled(color: .green)
    }
    
    // MARK: DisposeBag
    private let disposeBag = DisposeBag()
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupHierarchy()
        setupLayout()
        setupBind()
    }
    
    // MARK: Setup methods
    private func setupHierarchy() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(stackView)
        
        stackView.addArrangedSubview(variantControlLabel)
        stackView.addArrangedSubview(variantControl)
        
        stackView.addArrangedSubview(BaseSpacer())
        stackView.addArrangedSubview(BaseDivider())
        stackView.addArrangedSubview(BaseSpacer())
        
        badges.enumerated().forEach { index, badge in
            stackView.addArrangedSubview(badgeLabels[index])
            stackView.addArrangedSubview(badge)
        }
        
        stackView.addArrangedSubview(badgeWithIconLabel)
        stackView.addArrangedSubview(badgeWithIcon)
    }
    
    private func setupLayout() {
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalTo(scrollView)
            $0.height.equalTo(stackView.snp.height).offset(32)
        }
        
        stackView.snp.makeConstraints {
            $0.top.equalTo(contentView.safeAreaLayoutGuide.snp.top)
            $0.left.right.equalToSuperview().inset(16)
            $0.centerX.equalToSuperview()
        }
        
        variantControl.snp.makeConstraints {
            $0.width.equalTo(stackView.snp.width)
        }
    }
    
    private func setupBind() {
        variantControl.rx.selectedSegmentIndex
            .observe(on: MainScheduler.instance)
            .withUnretained(self)
            .subscribe(onNext: { owner, index in
                BasicBadgeColor.allCases.enumerated().forEach { colorIndex, color in
                    
                    owner.badges[colorIndex].styled(
                        color: color,
                        variant: BasicBadgeVariant.allCases[index]
                    )
                    
                }
                
                owner.badgeWithIcon.styled(
                    color: .green,
                    variant: BasicBadgeVariant.allCases[index]
                )
            })
            .disposed(by: disposeBag)
    }
}
