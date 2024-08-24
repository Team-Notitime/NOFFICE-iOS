//
//  OrganizationDetailView.swift
//  OrganizationPresent
//
//  Created by DOYEON LEE on 7/31/24.
//

import UIKit

import DesignSystem
import Assets

import SnapKit
import Then

class OrganizationDetailView: BaseView {
    // MARK: UI Constant
    private static let OrganizationProfileCardSize: CGFloat = 86
    
    // MARK: UI Component
    // - Navigation bar
    lazy var navigationBar = NofficeNavigationBar()
    
    // - Scroll view
    lazy var scrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = true
    }
    
    // - Contents view
    lazy var contentView = UIView().then {
        $0.backgroundColor = .grey50
    }
    
    // - Stack view
    lazy var stackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = GlobalViewConstant.SpacingUnit * 3
    }
    
    // - Organization profile
    lazy var organizationProfile = BaseHStack(
        spacing: GlobalViewConstant.SpacingUnit * 3
    ) {
        [
            organizationImageView,
            BaseVStack(spacing: 10) {
                [
                    BaseSpacer(),
                    organizationNameLabel,
                    organizationCategoryBadges,
                    BaseSpacer()
                ]
            }
        ]
    }
    
    lazy var organizationImageView = UIImageView(image: .imgProfileGroup).then {
        $0.setSize(
            width: Self.OrganizationProfileCardSize,
            height: Self.OrganizationProfileCardSize
        )
        $0.layer.cornerRadius = Self.OrganizationProfileCardSize / 2
        $0.layer.masksToBounds = true
    }
    
    lazy var organizationNameLabel = UILabel().then {
        $0.text = "Skeleton dummy"
        $0.setTypo(.heading3)
        $0.textColor = .grey800
    }
    
    lazy var organizationCategoryBadges = BaseHStack {
        [
            BaseSpacer()
        ]
    }
    
    // - Organization participant description
    lazy var organizationParticipantDescription = BaseHStack(
        alignment: .center,
        distribution: .equalCentering
    ) {
        [
            BaseSpacer(),
            UILabel().then {
                $0.text = "Leader"
                $0.setTypo(.body1m)
                $0.textColor = .grey400
            },
            leaderCountLabel,
            UILabel().then {
                $0.text = "Member"
                $0.setTypo(.body1m)
                $0.textColor = .grey400
            },
            memberCountLabel,
            BaseSpacer()
        ]
    }
    
    lazy var leaderCountLabel = UILabel().then {
        $0.text = "0"
        $0.setTypo(.body1m)
        $0.textColor = .grey800
    }
    
    lazy var memberCountLabel = UILabel().then {
        $0.text = "0"
        $0.setTypo(.body1m)
        $0.textColor = .grey800
    }
    
    // - Join waitlist button
    lazy var joinWaitlistButton = BaseButton {
        [
            UIImageView(image: .iconLoading),
            UILabel().then {
                $0.text = "가입을 대기 중인 멤버가 있어요!"
                $0.setTypo(.body1b)
                $0.textAlignment = .center
            }
        ]
    }.then {
        $0.styled(variant: .outline, color: .green, size: .medium)
        $0.isHidden = true
    }
    
    // - Announcement list collection view
    lazy var announcementsCollectionView = CompositionalCollectionView().then {
        $0.isScrollEnabled = false
    }
    
    // MARK: Setup
    public override func setupHierarchy() {
        backgroundColor = .grey50
        
        addSubview(navigationBar)
        
        addSubview(scrollView)
        
        scrollView.addSubview(contentView)
        
        scrollView.addSubview(stackView)
        
        stackView.addArrangedSubview(organizationProfile)
        
        stackView.addArrangedSubview(BaseDivider(color: .grey200))
        
        stackView.addArrangedSubview(
            BaseSpacer(size: GlobalViewConstant.SpacingUnit * 3)
        )
        
        stackView.addArrangedSubview(organizationParticipantDescription)
        
        stackView.addArrangedSubview(
            BaseSpacer(size: GlobalViewConstant.SpacingUnit * 2)
        )
        
        stackView.addArrangedSubview(joinWaitlistButton)
        
        stackView.addArrangedSubview(
            BaseSpacer(size: GlobalViewConstant.SpacingUnit * 2)
        )
        
        stackView.addArrangedSubview(announcementsCollectionView)
    }
    
    public override func setupLayout() {
        navigationBar.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.left.right.equalToSuperview()
        }
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom)
            $0.left.right.bottom.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalTo(scrollView.contentLayoutGuide)
            $0.width.equalTo(scrollView.frameLayoutGuide)
        }
        
        stackView.snp.makeConstraints {
            $0.top.equalToSuperview()
                .offset(GlobalViewConstant.SpacingUnit * 2)
            $0.left.right.equalToSuperview()
                .inset(GlobalViewConstant.PagePaddingLarge)
            $0.bottom.equalToSuperview()
        }
    }

    func updateCategories(_ categories: [String]) {
        let categoriesToDisplay = categories.isEmpty ? ["미지정"] : categories

        let badges = categoriesToDisplay.map { category in
            BaseBadge(
                contentsBudiler: {
                    [
                        UILabel().then {
                            $0.text = category
                            $0.setTypo(.body3b)
                        }
                    ]
                }
            ).then {
                $0.styled(color: .green, variant: .weak)
            }
        }
        
        organizationCategoryBadges
            .arrangedSubviews
            .forEach { $0.removeFromSuperview() }
        
        organizationCategoryBadges.addArrangedSubviews(badges + [BaseSpacer()])
    }
}
