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

public class SignupTermsPageView: BaseView {
    // MARK: UI Component
    // - Padding view
    lazy var contentView = UIView()
    
    // - Page title
    lazy var pageTitleLabel = UILabel().then {
        $0.text = "약관에 동의해주세요"
        $0.setTypo(.heading3)
        $0.textColor = .grey800
    }
    
    // - Page description
    lazy var pageDescriptionLabel = UILabel().then {
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
                        $0.setSize(width: 18, height: 18)
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
        
        contentView.addSubview(pageTitleLabel)
        
        contentView.addSubview(pageDescriptionLabel)
        
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
        
        pageTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
                .offset(FunnelConstant.spacingUnit * 2)
            $0.left.right.equalToSuperview()
                .inset(FunnelConstant.additionalPadding)
        }
        
        pageDescriptionLabel.snp.makeConstraints {
            $0.top.equalTo(pageTitleLabel.snp.bottom)
                .offset(FunnelConstant.spacingUnit)
            $0.left.right.equalToSuperview()
                .inset(FunnelConstant.additionalPadding)
        }
        
        allAgreeCheckBox.snp.makeConstraints {
            $0.top.equalTo(pageDescriptionLabel.snp.bottom)
                .offset(FunnelConstant.spacingUnit * 4)
            $0.left.right.equalToSuperview()
                .inset(FunnelConstant.additionalPadding)
        }
        
        divider.snp.makeConstraints {
            $0.top.equalTo(allAgreeCheckBox.snp.bottom)
                .offset(FunnelConstant.spacingUnit * 1.5)
            $0.left.right.equalToSuperview()
                .inset(FunnelConstant.additionalPadding)
        }
        
        termsOptonGroup.snp.makeConstraints {
            $0.top.equalTo(divider.snp.bottom)
                .offset(FunnelConstant.spacingUnit * 1.5)
            $0.left.right.equalToSuperview()
                .inset(FunnelConstant.additionalPadding)
        }
        
        nextButton.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.bottom.equalTo(safeAreaLayoutGuide).inset(16)
        }
    }
}
