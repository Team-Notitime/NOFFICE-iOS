//
//  SignupView.swift
//  SignupPresent
//
//  Created by DOYEON LEE on 7/17/24.
//

import AuthenticationServices
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
    
    lazy var appleSigninButton = ASAuthorizationAppleIDButton(
        type: .signIn,
        style: .black
    ).then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.isUserInteractionEnabled = false
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = 12
    }
    
    lazy var kakaoSigninButton = UIImageView(image: .imgKakaoLogin).then {
        $0.contentMode = .scaleAspectFill
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = 12
    }
    
    // MARK: Setup
    public override func setupHierarchy() { 
        addSubview(backgroundLogo)
        
        addSubview(logo)
        
        addSubview(appleSigninButton)
        
        addSubview(kakaoSigninButton)
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
        
        appleSigninButton.snp.makeConstraints {
            $0.left.right.equalToSuperview()
                .inset(GlobalViewConstant.PagePadding)
            $0.height.equalTo(50)
            $0.bottom.equalToSuperview()
                .inset(GlobalViewConstant.PagePadding * 4)
        }
        
        kakaoSigninButton.snp.makeConstraints {
            $0.left.right.equalToSuperview()
                .inset(GlobalViewConstant.PagePadding)
            $0.bottom.equalTo(appleSigninButton.snp.top)
                .offset(-GlobalViewConstant.SpacingUnit * 4)
            $0.height.equalTo(50)
        }
    }
}

// MARK: - DisplayModel
public extension SignupView { }
