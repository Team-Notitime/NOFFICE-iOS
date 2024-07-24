//
//  EditContentsPageView.swift
//  NewAnnouncementPresent
//
//  Created by DOYEON LEE on 7/22/24.
//

import Foundation

import UIKit

import DesignSystem
import Assets
import AnnouncementEntity

import SnapKit
import Then

class EditContentsPageView: BaseView {
    // MARK: UI Component
    // - Scroll view
    lazy var scrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = true
    }
    
    // - Content view
    lazy var contentView = UIView()
    
    // - Title text field
    lazy var titleTextField = BaseTextField(
        titleBuilder: {
            [
                UILabel().then {
                    $0.text = "제목"
                    $0.textColor = .grey800
                    $0.setTypo(.body1b)
                }
            ]
        }
    ).then {
        $0.placeholder = "제목을 입력해주세요"
        $0.styled(variant: .outlined)
    }
    
    // - Body text field
    lazy var bodyTextView = BaseTextView(
        titleBuilder: {
            [
                UILabel().then {
                    $0.text = "내용"
                    $0.textColor = .grey800
                    $0.setTypo(.body1b)
                }
            ]
        }
    ).then {
        $0.placeholder = "내용을 입력해주세요"
        $0.minimumHeight = 200
        $0.maximumHeight = 400
        $0.styled(variant: .outlined)
    }
    
    // - Go edit page buttons
    lazy var templateStack = BaseVStack(contents: [
        editDateTime,
        editLocation,
        editTodo,
        editNotification
    ])
    
    lazy var editDateTime = NofficeList(
        option: AnnouncementTemplateType.date
    ) { option in
        [
            UILabel().then {
                $0.text = "\(option.title)"
                $0.setTypo(.body2b)
                $0.textAlignment = .center
            },
            BaseSpacer(),
            UIImageView(image: .iconChevronRight).then {
                $0.setSize(width: 18, height: 18)
            }
        ]
    }.then {
        $0.automaticToggle = false
    }
    
    lazy var editLocation = NofficeList(
        option: AnnouncementTemplateType.location
    ) { option in
        [
            UILabel().then {
                $0.text = "\(option.title)"
                $0.setTypo(.body2b)
                $0.textAlignment = .center
            },
            BaseSpacer(),
            UIImageView(image: .iconChevronRight).then {
                $0.setSize(width: 18, height: 18)
            }
        ]
    }.then {
        $0.automaticToggle = false
    }
    
    lazy var editTodo = NofficeList(
        option: AnnouncementTemplateType.todo
    ) { option in
        [
            UILabel().then {
                $0.text = "\(option.title)"
                $0.setTypo(.body2b)
                $0.textAlignment = .center
            },
            BaseSpacer(),
            UIImageView(image: .iconChevronRight).then {
                $0.setSize(width: 18, height: 18)
            }
        ]
    }.then {
        $0.automaticToggle = false
    }
    
    lazy var editNotification = NofficeList(
        option: AnnouncementTemplateType.notification
    ) { option in
        [
            UILabel().then {
                $0.text = "\(option.title)"
                $0.setTypo(.body2b)
                $0.textAlignment = .center
            },
            BaseSpacer(),
            UIImageView(image: .iconChevronRight).then {
                $0.setSize(width: 18, height: 18)
            }
        ]
    }.then {
        $0.automaticToggle = false
    }
    
    // - Complete button
    lazy var completeButton = BaseButton(
        contentsBuilder: {
            [
                UILabel().then {
                    $0.text = "완료"
                    $0.setTypo(.body1b)
                }
            ]
        }
    ).then {
        $0.styled(variant: .fill, color: .green)
        $0.isEnabled = false
    }
    
    // MARK: Setup
    override func setupHierarchy() {
        addSubview(scrollView)
        
        scrollView.addSubview(contentView)
        
        contentView.addSubview(titleTextField)
        
        contentView.addSubview(bodyTextView)
        
        contentView.addSubview(templateStack)
        
        contentView.addSubview(completeButton)
    }
    
    override func setupLayout() { 
        translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.width.equalTo(scrollView.snp.width)
        }
        
        titleTextField.snp.makeConstraints {
            $0.top.equalToSuperview()
                .offset(FunnelConstant.spacingUnit)
            $0.left.right.equalToSuperview()
                .inset(GlobalViewConstant.pagePadding)
        }
        
        bodyTextView.snp.makeConstraints {
            $0.top.equalTo(titleTextField.snp.bottom)
                .offset(FunnelConstant.spacingUnit)
            $0.left.right.equalToSuperview()
                .inset(GlobalViewConstant.pagePadding)
        }
        
        templateStack.snp.makeConstraints {
            $0.top.equalTo(bodyTextView.snp.bottom)
                .offset(FunnelConstant.spacingUnit)
            $0.left.right.equalToSuperview()
                .inset(GlobalViewConstant.pagePadding)
            $0.bottom.equalToSuperview()
                .inset(FunnelConstant.spacingUnit * 8)
        }
        
        completeButton.snp.makeConstraints {
            $0.left.right.equalToSuperview()
                .inset(GlobalViewConstant.pagePadding)
            $0.bottom.equalTo(keyboardLayoutGuide.snp.top)
                .offset(-FunnelConstant.spacingUnit)
        }
    }
}
