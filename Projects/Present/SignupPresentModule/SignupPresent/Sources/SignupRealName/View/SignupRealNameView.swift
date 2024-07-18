//
//  SignupRealNameView.swift
//  SignupPresent
//
//  Created by DOYEON LEE on 7/18/24.
//

import UIKit

import DesignSystem
import Assets

import SnapKit
import Then

public class SignupRealNameView: BaseView {
    // MARK: UI Constant
    private let additionalPagePadding: CGFloat = 14
    
    private let sectionSpacingUnit: CGFloat = 12
    
    // MARK: UI Component
    // - Padding view
    lazy var contentView = UIView()
    
    // - Page title
    lazy var pageTitleFirstLineLabel = UILabel().then {
        $0.text = "가입을 환영해요!"
        $0.setTypo(.heading3)
        $0.textColor = .grey800
        $0.numberOfLines = 0
    }
    
    lazy var pageTitleSecondLineLabel = UILabel().then {
        $0.text = "여러분의 이름을 알려주세요"
        $0.setTypo(.heading3)
        $0.textColor = .grey800
        $0.numberOfLines = 0
    }
    
    // - Textfield
    lazy var nameTextField = BaseTextField().then {
        $0.placeholder = "실명을 입력해주세요"
        $0.styled(variant: .outlined, shape: .round)
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
    public override func setupHierarchy() {
        addSubview(contentView)
        
        contentView.addSubview(pageTitleFirstLineLabel)
        
        contentView.addSubview(pageTitleSecondLineLabel)
        
        contentView.addSubview(nameTextField)
        
        contentView.addSubview(completeButton)
    }
    
    public override func setupLayout() { 
        contentView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.left.right.equalToSuperview()
                .inset(GlobalViewConstant.pagePadding)
        }
        
        pageTitleFirstLineLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
                .offset(FunnelConstant.spacingUnit * 2)
            $0.left.right.equalToSuperview()
                .inset(additionalPagePadding)
        }
        
        pageTitleSecondLineLabel.snp.makeConstraints {
            $0.top.equalTo(pageTitleFirstLineLabel.snp.bottom)
                .offset(FunnelConstant.spacingUnit / 2)
            $0.left.right.equalToSuperview()
                .inset(additionalPagePadding)
        }
        
        nameTextField.snp.makeConstraints {
            $0.top.equalTo(pageTitleSecondLineLabel.snp.bottom)
                .offset(FunnelConstant.spacingUnit * 4)
            $0.left.right.equalToSuperview()
        }
        
        completeButton.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.bottom.equalTo(keyboardLayoutGuide.snp.top)
                .offset(-FunnelConstant.spacingUnit * 2)
        }
    }
}
