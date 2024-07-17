//
//  SignupView.swift
//  SignupPresent
//
//  Created by DOYEON LEE on 7/17/24.
//

import UIKit

import DesignSystem
import Assets

import SnapKit
import Then

public class SignupView: BaseView {
    // MARK: UI Constant
    
    // MARK: UI Component
    lazy var logo = UIImageView(image: .logoHorizontal).then {
        $0.contentMode = .scaleAspectFit
    }
    
    lazy var dummyButton = BaseButton(
        contentsBuilder: {
            [
                UILabel().then {
                    $0.text = "애플 로그인"
                    $0.setTypo(.body1b)
                }
            ]
        }
    ).then {
        $0.styled(variant: .fill, color: .ghost, size: .medium)
    }
    
    // MARK: Setup
    public override func setupHierarchy() { 
        addSubview(dummyButton)
        addSubview(logo)
    }
    
    public override func setupLayout() { 
        logo.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().multipliedBy(0.7)
        }
        
        dummyButton.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(GlobalViewConstant.pagePadding)
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().multipliedBy(1.5)
        }
    }
}

// MARK: - DisplayModel
public extension SignupView { }
