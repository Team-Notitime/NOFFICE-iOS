//
//  EditLocationView.swift
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

class EditPlaceView: BaseView {
    // MARK: UI Component
    // - Navigation bar
    lazy var navigationBar = NofficeNavigationBar().then {
        $0.title = "장소 선택"
    }
    
    // - Content view
    lazy var stackView = UIStackView().then {
        $0.axis = .vertical
        $0.alignment = .fill
        $0.distribution = .fill
        $0.spacing = GlobalViewConstant.SpacingUnit * 2
    }
    
    // - Title
    lazy var header = NofficeFunnelHeader().then {
        $0.funnelType = .newAnnouncement
        $0.title = "이벤트 장소를 알려주세요"
    }
    
    // - Segment
    lazy var placeTypeSegmentControl = BaseSegmentControl(
        source: AnnouncementPlaceType.allCases,
        itemBuilder: { option in
            [
                UILabel().then {
                    $0.text = option.title
                    $0.textAlignment = .center
                    $0.setTypo(.body1b)
                }
            ]
        }
    ).then {
        $0.styled(variant: .flat, color: .green)
    }
    
    // - Place name text field
    lazy var placeNameStackView = BaseHStack(
        distribution: .fill
    ) {
        [
            placeNameLabel,
            BaseHStack {
                [
                    placeNameTextField
                ]
            }
        ]
    }
    
    lazy var placeNameLabel = UILabel().then {
        $0.text = "이름"
        $0.setTypo(.body2b)
        $0.textColor = .grey500
        $0.numberOfLines = 2
    }
    
    lazy var placeNameTextField = BaseTextField(
        suffixBuilder: { 
            [
                placeNameDeleteButton
            ]
        }
    ).then {
        $0.placeholder = "입력해주세요"
        $0.styled(variant: .outlined)
    }
    
    lazy var placeNameDeleteButton = UIImageView(image: .imgXCircle).then {
        $0.contentMode = .scaleAspectFit
        $0.setSize(width: 20, height: 20)
        $0.layer.cornerRadius = 10
        $0.isUserInteractionEnabled = true
        $0.isHidden = true
    }
    
    // - Place link text field
    lazy var placeLinkStackView = BaseHStack(
        distribution: .fill
    ) {
        [
            placeLinkLabel,
            BaseHStack {
                [
                    placeLinkTextField
                ]
            }
        ]
    }
    
    lazy var placeLinkLabel = UILabel().then {
        $0.text = "장소\n링크"
        $0.setTypo(.body2b)
        $0.textColor = .grey500
        $0.numberOfLines = 2
    }
    
    lazy var placeLinkTextField = BaseTextField(
        suffixBuilder: {
            [
                placeLinkDeleteButton
            ]
        },
        descriptionBuilder: {
            [
                BaseSpacer(),
                placeLinkErrorMessage
            ]
        }
    ).then {
        $0.placeholder = "입력해주세요"
        $0.styled(variant: .outlined)
    }
    
    lazy var placeLinkDeleteButton = UIImageView(image: .imgXCircle).then {
        $0.contentMode = .scaleAspectFit
        $0.setSize(width: 20, height: 20)
        $0.layer.cornerRadius = 10
        $0.isUserInteractionEnabled = true
        $0.isHidden = true
    }
    
    lazy var placeLinkErrorMessage = UILabel().then {
        $0.text = "올바른 URL 형식이 아닙니다"
        $0.setTypo(.detail)
        $0.numberOfLines = 1
        $0.layer.opacity = 0.0
    }
    
    // - Open graph card
    lazy var openGraphCard = BaseCard(
        contentsBuilder: {
            [
                openGraphImageView,
                BaseHStack {[
                    BaseSpacer(size: 16, orientation: .horizontal),
                    BaseVStack {[
                        BaseSpacer(size: 2, fixedSize: true),
                        openGraphTitleLabel,
                        openGraphLinkLabel,
                        BaseSpacer(size: 2, fixedSize: true)
                    ]},
                    BaseSpacer(size: 16, orientation: .horizontal)
                ]},
                BaseSpacer()
            ]
        }
    ).then {
        $0.styled(variant: .outline, padding: .none)
    }
    
    lazy var openGraphImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.setSize(height: 120)
    }
    
    lazy var openGraphTitleLabel = UILabel().then {
        $0.setTypo(.body2)
        $0.textColor = .grey800
        $0.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
    }
    
    lazy var openGraphLinkLabel = UILabel().then {
        $0.setTypo(.body2)
        $0.textColor = .grey400
        $0.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
    }
    
    // - Save button
    lazy var saveButton = BaseButton(
        contentsBuilder: {
            [
                UILabel().then {
                    $0.text = "저장"
                    $0.setTypo(.body1b)
                }
            ]
        }
    ).then {
        $0.styled(variant: .fill, color: .green, size: .large)
    }
    
    // MARK: Setup
    override func setupHierarchy() {
        addSubview(navigationBar)
        
        addSubview(stackView)
        
        stackView.addArrangedSubview(header)
        
        stackView.addArrangedSubview(placeTypeSegmentControl)
        
        stackView.addArrangedSubview(placeNameStackView)
        
        stackView.addArrangedSubview(placeLinkStackView)
        
        stackView.addArrangedSubview(openGraphCard)
        
        addSubview(saveButton)
    }
    
    override func setupLayout() {
        navigationBar.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide.snp.top)
            $0.left.right.equalToSuperview()
        }
        
        stackView.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom)
            $0.left.right.equalToSuperview()
                .inset(GlobalViewConstant.PagePadding)
    
        }
        
        saveButton.snp.makeConstraints {
            $0.left.right.equalToSuperview()
                .inset(GlobalViewConstant.PagePadding)
            $0.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
                .inset(FunnelConstant.SpacingUnit)
        }
    }
}
