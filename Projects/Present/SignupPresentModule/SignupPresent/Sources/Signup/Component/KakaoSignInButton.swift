//
//  KakaoSigninButton.swift
//  SignupPresent
//
//  Created by DOYEON LEE on 11/10/24.
//

import UIKit

import Assets

import RxSwift
import RxCocoa
import SnapKit
import Then

final public class KakaoSignInButton: UIButton {
    // MARK: Component
    private lazy var kakaoLoginImageView = UIImageView(image: .imgKakaoLogin).then {
        $0.contentMode = .scaleAspectFill
    }
    
    // MARK: DisposeBag
    private let disposeBag = DisposeBag()
    
    // MARK: Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupHierarchy()
        setupLayout()
        setupBind()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupHierarchy()
        setupLayout()
        setupBind()
    }
    
    // MARK: Setup
    private func setupHierarchy() {
        self.addSubview(kakaoLoginImageView)
    }
    
    private func setupLayout() {
        kakaoLoginImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func setupBind() { }
}
