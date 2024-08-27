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
    // MARK: UI Component
    lazy var backgroundLogo = UIImageView(image: .iconBackgroundLogo).then {
        $0.tintColor = .green500
        $0.contentMode = .scaleAspectFit
    }
    
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
    
    lazy var appleSigninButton = AppleSignInButton()
    
    // MARK: Setup
    public override func setupHierarchy() { 
        addSubview(backgroundLogo)
        
        addSubview(logo)
        
        addSubview(dummyButton)
        
        addSubview(appleSigninButton)
    }
    
    public override func setupLayout() { 
        backgroundLogo.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(100)
            $0.left.right.equalToSuperview()
        }
        
        logo.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().multipliedBy(0.5)
            $0.width.equalTo(200)
        }
        
//        dummyButton.snp.makeConstraints {
//            $0.left.right.equalToSuperview().inset(GlobalViewConstant.PagePadding)
//            $0.centerX.equalToSuperview()
//            $0.centerY.equalToSuperview().multipliedBy(1.5)
//        }
        
        appleSigninButton.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(GlobalViewConstant.PagePadding)
            $0.top.equalTo(dummyButton.snp.bottom).offset(16)
            $0.height.equalTo(50)
        }
    }
}

// MARK: - DisplayModel
public extension SignupView { }
