//
//  SignupTermsView.swift
//  SignupPresent
//
//  Created by DOYEON LEE on 7/18/24.
//

import UIKit

import DesignSystem
import Assets

import SnapKit
import Then

public class SignupTermsView: BaseView {
    // MARK: UI Constant
    private let additionalPagePadding: CGFloat = 14
    private let sectionSpacingUnit: CGFloat = 12
    
    // MARK: UI Component
    // - Padding view
    lazy var contentView = UIView()
    
    // - Text section
    lazy var termsTitleLabel = UILabel().then {
        $0.text = "약관에 동의해주세요"
        $0.setTypo(.heading3)
        $0.textColor = .grey800
    }
    
    lazy var termsDescriptionLabel = UILabel().then {
        $0.text = "여러분의 개인정보와 서비스 이용 권리를 잘 지켜드릴게요."
        $0.setTypo(.body1m)
        $0.textColor = .grey600
        $0.numberOfLines = 0
    }
    
    // - Check box (all checked)
    lazy var allAgreeCheckBox = BaseToggleButton<SignupTermsReactor.TermOption>(
        option: SignupTermsReactor.TermOption(
            order: -1,
            text: "모두 동의",
            description: "서비스 이용을 위해 아래의 약관을 모두 동의합니다."
        ),
        itemBuilder: { option in
            [
                BaseVStack(spacing: 6) {
                    [
                        UILabel().then {
                            $0.text = option.text
                            $0.setTypo(.body1m)
                            $0.textColor = .grey800
                        },
                        UILabel().then {
                            $0.text = option.description
                            $0.setTypo(.body3)
                            $0.textColor = .grey600
                        }
                    ]
                }
            ]
        }
    ).then {
        $0.styled(shape: .circle)
    }
    
    // - Divider
    lazy var divider = BaseDivider()
    
    // - Check box group
    lazy var termsOptionIconViews: [UIView] = [] // for binding
    
    lazy var termsOptonGroup = BaseCheckBoxGroup(
        source: Array(SignupTermsReactor.TermOptionType.allCases.map { $0.termOption }),
        itemBuilder: { option in
            BaseToggleButton<SignupTermsReactor.TermOption>(
                option: option,
                itemBuilder: { option in
                    let icon = UIImageView(image: .iconChevronRight).then {
                        $0.contentMode = .scaleAspectFit
                        $0.tintColor = .grey400
                        $0.isUserInteractionEnabled = true
                    }
                    self.termsOptionIconViews.append(icon)
                    return [
                        UILabel().then {
                            $0.text = option.text
                            $0.setTypo(.body1m)
                            $0.textColor = .grey800
                        },
                        icon
                    ]
                }
            ).then {
                $0.styled(shape: .circle)
            }
        }
    ).then {
        $0.gridStyled(verticalSpacing: 16)
    }
    
    // - Next button
    lazy var nextButton = BaseButton(
        contentsBuilder: {
            [
                UILabel().then {
                    $0.text = "다음"
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
        
        contentView.addSubview(termsTitleLabel)
        contentView.addSubview(termsDescriptionLabel)
        
        contentView.addSubview(allAgreeCheckBox)
        
        contentView.addSubview(divider)
        
        contentView.addSubview(termsOptonGroup)
        
        contentView.addSubview(nextButton)
    }
    
    public override func setupLayout() {
        contentView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.left.right.equalToSuperview().inset(GlobalViewConstant.pagePadding)
        }
        
        termsTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(sectionSpacingUnit * 2)
            $0.left.right.equalToSuperview().inset(additionalPagePadding)
        }
        
        termsDescriptionLabel.snp.makeConstraints {
            $0.top.equalTo(termsTitleLabel.snp.bottom).offset(sectionSpacingUnit)
            $0.left.right.equalToSuperview().inset(additionalPagePadding)
        }
        
        allAgreeCheckBox.snp.makeConstraints {
            $0.top.equalTo(termsDescriptionLabel.snp.bottom).offset(sectionSpacingUnit * 4)
            $0.left.right.equalToSuperview().inset(additionalPagePadding)
        }
        
        divider.snp.makeConstraints {
            $0.top.equalTo(allAgreeCheckBox.snp.bottom).offset(sectionSpacingUnit * 1.5)
            $0.left.right.equalToSuperview().inset(additionalPagePadding)
        }
        
        termsOptonGroup.snp.makeConstraints {
            $0.top.equalTo(divider.snp.bottom).offset(sectionSpacingUnit * 1.5)
            $0.left.right.equalToSuperview().inset(additionalPagePadding)
        }
        
        nextButton.snp.makeConstraints {
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
            $0.bottom.equalTo(safeAreaLayoutGuide).inset(16)
        }
    }
}
