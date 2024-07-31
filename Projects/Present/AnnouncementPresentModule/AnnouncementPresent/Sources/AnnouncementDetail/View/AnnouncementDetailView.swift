//
//  AnnouncementDetailView.swift
//  AnnouncementPresent
//
//  Created by DOYEON LEE on 7/26/24.
//

import UIKit

import DesignSystem
import Assets

import SnapKit
import Then

public class AnnouncementDetailView: BaseView {
    // MARK: UI Constant
    
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
        $0.spacing = GlobalViewConstant.spacingUnit * 3
    }
    
    // - Title label
    lazy var titleLabel = UILabel().then {
        $0.text = "Skeleton dummy"
        $0.setTypo(.heading3)
        $0.textColor = .grey800
        $0.numberOfLines = 0
    }
    
    // - Created date label
    lazy var createdDateLabel = UILabel().then {
        $0.text = "Skeleton dummy"
        $0.setTypo(.body2)
        $0.textColor = .grey400
    }
    
    // - Organization profile card
    lazy var organizationProfile = BaseHStack {
        [
            organizationProfileImage,
            BaseVStack {
                [
                    orgnizationNameLabel,
                    organizationCategoryLabel
                ]
            }
        ]
    }.then {
        $0.setContentCompressionResistancePriority(.required, for: .vertical)
    }
    
    lazy var organizationProfileImage = UIImageView(image: .imgProfileGroup).then {
        $0.setSize(width: 40, height: 40)
        $0.layer.cornerRadius = 40 / 2
        $0.layer.masksToBounds = true
    }
    
    lazy var orgnizationNameLabel = UILabel().then {
        $0.text = "Skeleton dummy"
        $0.setTypo(.body2)
        $0.textColor = .grey700
        $0.setContentCompressionResistancePriority(.required, for: .vertical)
    }
    
    lazy var organizationCategoryLabel = UILabel().then {
        $0.text = "Skeleton dummy"
        $0.setTypo(.body3)
        $0.textColor = .grey500
        $0.setContentCompressionResistancePriority(.required, for: .vertical)
    }
    
    // - Event date card
    lazy var eventDateCard = BaseCard(
        contentsBuilder: {
            [
                BaseHStack {
                    [
                        UIImageView(image: .imgCalenderGreen).then {
                            $0.setSize(width: 24, height: 24)
                            $0.contentMode = .scaleAspectFit
                        },
                        UILabel().then {
                            $0.text = "이벤트 일시"
                            $0.setTypo(.body2)
                            $0.textColor = .grey500
                        }
                    ]
                },
                eventDateLabel
            ]
        }
    ).then {
        $0.styled(variant: .translucent, color: .background)
    }
    
    lazy var eventDateLabel = UILabel().then {
        $0.text = "Skeleton dummy"
        $0.setTypo(.body1m)
        $0.textColor = .grey800
        $0.numberOfLines = 2
    }
    
    // - Event place card
    lazy var eventPlaceCard = BaseCard(
        contentsBuilder: {
            [
                BaseHStack {
                    [
                        UIImageView(image: .imgMappinYellow).then {
                            $0.setSize(width: 24, height: 24)
                            $0.contentMode = .scaleAspectFit
                        },
                        UILabel().then {
                            $0.text = "이벤트 장소"
                            $0.setTypo(.body2)
                            $0.textColor = .grey500
                        }
                    ]
                },
                BaseHStack {
                    [
                        eventPlaceLabel,
                        UIImageView(image: .iconChevronRight).then {
                            $0.setSize(width: 24, height: 24)
                            $0.contentMode = .scaleAspectFit
                            $0.tintColor = .yellow500
                        }
                    ]
                }
            ]
        }
    ).then {
        $0.styled(variant: .translucent, color: .background)
    }
    
    lazy var eventPlaceLabel = UILabel().then {
        $0.text = "Skeleton dummy"
        $0.setTypo(.body1m)
        $0.textColor = .grey800
        $0.numberOfLines = 2
    }
    
    // - Event body label
    lazy var eventBodyCard = BaseCard(
        contentsBuilder: {
            [
                eventBodyLabel
            ]
        }
    ).then {
        $0.styled(variant: .translucent, color: .background, padding: .medium)
    }
    
    lazy var eventBodyLabel = UILabel().then {
        $0.text = "Skeleton dummy \n \n"
        $0.tintColor = .grey800
        $0.setTypo(.body2)
        $0.setLineHeight(multiplier: 1.5)
        $0.numberOfLines = 0
    }
    
    // - Todo list collection view
    lazy var todoListCard = BaseCard(
        contentsBuilder: {
            [
                todoTitleStack,
                todoListCollectionView
            ]
        }
    ).then {
        $0.styled(variant: .translucent, color: .background, padding: .medium)
    }
    
    lazy var todoTitleStack = BaseHStack {
        [
            todoTitleLabel,
            UIImageView(image: .iconCheck).then {
                $0.setSize(width: 18, height: 18)
                $0.contentMode = .scaleAspectFit
                $0.tintColor = .blue500
            },
            BaseSpacer()
        ]
    }
    
    lazy var todoTitleLabel = UILabel().then {
        $0.text = "TO DO LIST"
        $0.setTypo(.body0b)
        $0.textColor = .grey800
    }
    
    lazy var todoListCollectionView = CompositionalCollectionView().then {
        $0.isScrollEnabled = false
    }
    
    // MARK: Setup
    public override func setupHierarchy() {
        backgroundColor = .grey50
        
        addSubview(navigationBar)
        
        addSubview(scrollView)
        
        scrollView.addSubview(contentView)
        
        scrollView.addSubview(stackView)
        
        stackView.addArrangedSubview(titleLabel)
        
        stackView.addArrangedSubview(createdDateLabel)
        
        stackView.addArrangedSubview(
            BaseSpacer(size: GlobalViewConstant.spacingUnit * 6)
        )
        
        stackView.addArrangedSubview(BaseDivider(color: .grey200))
        
        stackView.addArrangedSubview(
            BaseSpacer(size: GlobalViewConstant.spacingUnit * 6)
        )
        
        stackView.addArrangedSubview(organizationProfile)
        
        stackView.addArrangedSubview(
            BaseSpacer(size: GlobalViewConstant.spacingUnit * 2)
        )
        
        stackView.addArrangedSubview(eventDateCard)
        
        stackView.addArrangedSubview(eventPlaceCard)
        
        stackView.addArrangedSubview(eventBodyCard)
        
        stackView.addArrangedSubview(
            BaseSpacer(size: GlobalViewConstant.spacingUnit * 2)
        )
        
        stackView.addArrangedSubview(todoListCard)
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
                .offset(GlobalViewConstant.spacingUnit * 2)
            $0.left.right.equalToSuperview()
                .inset(GlobalViewConstant.pagePaddingLarge)
            $0.bottom.equalToSuperview()
        }
    }
}
