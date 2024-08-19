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
    
    // - Announcement card
    lazy var announcementCard = BaseCard(
        contentsBuilder: {
            [
                BaseVStack(spacing: 18) {
                    let menus = [
                        ("앱 버전", "00.00.00"),
                        // TODO: 추후 추가 예정
//                        ("문의하기", nil),
//                        ("공지사항", nil),
                        ("서비스 이용 약관", nil),
                        ("개인정보 처리 방침", nil)
                    ].map { (title, rightText) in
                        BaseHStack {
                            [
                                UILabel().then {
                                    $0.text = title
                                    $0.setTypo(.body2m)
                                    $0.textColor = .grey800
                                },
                                BaseSpacer(),
                                rightText != nil ? UILabel().then {
                                    $0.text = rightText
                                    $0.setTypo(.body2m)
                                    $0.textColor = .grey500
                                } : UIImageView(image: .iconChevronRight).then {
                                    $0.contentMode = .scaleAspectFit
                                    $0.setSize(width: 18, height: 18)
                                    $0.tintColor = .grey500
                                }
                            ]
                        }
                    }

                    return [
                        UILabel().then {
                            $0.text = "공지사항"
                            $0.setTypo(.body3m)
                            $0.textColor = .grey500
                        }
                    ] + menus
                }
            ]
        }
    ).then {
        $0.styled(variant: .translucent, color: .background, padding: .large)
    }
    
    // - App setting card
    lazy var appSettingCard = BaseCard(
        contentsBuilder: {
            [
                BaseVStack(spacing: 18) {
                    [
                        UILabel().then {
                            $0.text = "앱 설정"
                            $0.setTypo(.body3m)
                            $0.textColor = .grey500
                        },
                        BaseHStack {
                            [
                                UILabel().then {
                                    $0.text = "알림 설정"
                                    $0.setTypo(.body2m)
                                    $0.textColor = .grey800
                                },
                                BaseSpacer(),
                                UISwitch().then {
                                    $0.isOn = true
                                    $0.onTintColor = .green600
                                }
                            ]
                        }
                    ]
                }
            ]
        }
    ).then {
        $0.styled(variant: .translucent, color: .background, padding: .large)
    }
    
    // - Etc card
    lazy var etcCard = BaseCard(
        contentsBuilder: {
            [
                BaseVStack(spacing: 18) {
                    [
                        UILabel().then {
                            $0.text = "앱기타"
                            $0.setTypo(.body3m)
                            $0.textColor = .grey500
                        },
                        BaseHStack {
                            [
                                UILabel().then {
                                    $0.text = "정보 동의 설정"
                                    $0.setTypo(.body2m)
                                    $0.textColor = .grey800
                                },
                                BaseSpacer(),
                                UIImageView(image: .iconChevronRight).then {
                                   $0.contentMode = .scaleAspectFit
                                   $0.setSize(width: 18, height: 18)
                                   $0.tintColor = .grey500
                               }
                            ]
                        },
                        BaseHStack {
                            [
                                UILabel().then {
                                    $0.text = "회원 탈퇴"
                                    $0.setTypo(.body2m)
                                    $0.textColor = .grey800
                                },
                                BaseSpacer(),
                                UIImageView(image: .iconChevronRight).then {
                                   $0.contentMode = .scaleAspectFit
                                   $0.setSize(width: 18, height: 18)
                                   $0.tintColor = .grey500
                               }
                            ]
                        },
                        logoutRow
                    ]
                }
            ]
        }
    ).then {
        $0.styled(variant: .translucent, color: .background, padding: .large)
    }
    
    lazy var logoutRow = BaseHStack {
        [
            UILabel().then {
                $0.text = "로그아웃"
                $0.setTypo(.body2m)
                $0.textColor = .red500
            },
            BaseSpacer(),
            UIImageView(image: .iconChevronRight).then {
               $0.contentMode = .scaleAspectFit
               $0.setSize(width: 18, height: 18)
               $0.tintColor = .red500
           }
        ]
    }

    // MARK: Setup
    public override func setupHierarchy() {
        backgroundColor = .grey50
        
        addSubview(navigationBar)
        
        addSubview(scrollView)
        
        scrollView.addSubview(contentView)
        
        scrollView.addSubview(stackView)
        
        stackView.addArrangedSubview(userProfile)
        
        stackView.addArrangedSubview(announcementCard)
        
        stackView.addArrangedSubview(appSettingCard)
        
        stackView.addArrangedSubview(etcCard)
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
