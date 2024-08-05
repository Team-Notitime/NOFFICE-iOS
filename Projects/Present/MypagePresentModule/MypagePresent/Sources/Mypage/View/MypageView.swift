//
//  MypageView.swift
//  MypagePresent
//
//  Created by DOYEON LEE on 8/2/24.
//

import UIKit

import DesignSystem
import Assets

import SnapKit
import Then

public class MypageView: BaseView {
    // MARK: UI Constant
    private static let UserProfileCardSize: CGFloat = 76
    
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
    
    // - Profile
    lazy var userProfile = BaseHStack(
        spacing: GlobalViewConstant.SpacingUnit * 3
    ) {
        [
            userImageView,
            BaseVStack(spacing: 10) {
                [
                    BaseSpacer(),
                    BaseHStack {
                        [
                            userNameLabel,
                            UIImageView(image: .iconEdit).then {
                                $0.contentMode = .scaleAspectFit
                                $0.setSize(width: 22, height: 22)
                                $0.tintColor = .green600
                            },
                            BaseSpacer()
                        ]
                    },
                    emailLabel,
                    BaseSpacer()
                ]
            }
        ]
    }
    
    lazy var userImageView = UIImageView(image: .imgProfileUser).then {
        $0.setSize(
            width: Self.UserProfileCardSize,
            height: Self.UserProfileCardSize
        )
        $0.layer.cornerRadius = Self.UserProfileCardSize / 2
        $0.layer.masksToBounds = true
    }
    
    lazy var userNameLabel = UILabel().then {
        $0.text = "김지은 님"
        $0.setTypo(.heading3)
        $0.textColor = .grey800
    }
    
    lazy var emailLabel = UILabel().then {
        $0.text = "guest@noffice.com"
        $0.setTypo(.body2)
        $0.textColor = .grey500
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
        
        stackView.addArrangedSubview(userProfile)
        
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
}
