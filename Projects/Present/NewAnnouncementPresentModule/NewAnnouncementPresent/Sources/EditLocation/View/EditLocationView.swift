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

class EditLocationView: BaseView {
    // MARK: UI Component
    // - Navigation bar
    lazy var navigationBar = NofficeNavigationBar().then {
        $0.title = "장소 선택"
    }
    
    // - Content view
    lazy var contentView = UIView()
    
    // - Title
    lazy var header = NofficeFunnelHeader().then {
        $0.funnelType = .newAnnouncement
        $0.title = "이벤트 장소를 알려주세요"
    }
    
    // - Segment
    lazy var segment = BaseSegmentControl(
        source: AnnouncementLocationType.allCases,
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
    
    // - Location name text field
    lazy var locationNameLabel = UILabel().then {
        $0.text = "이름"
        $0.setTypo(.body2b)
        $0.textColor = .grey500
    }
    
    lazy var locationNameDeleteButton = UIImageView(image: .imgXCircle).then {
        $0.contentMode = .scaleAspectFit
        $0.setSize(width: 20, height: 20)
        $0.layer.cornerRadius = 10
        $0.isUserInteractionEnabled = true
        $0.isHidden = true
    }
    
    lazy var locationNameTextField = BaseTextField(
        suffixBuilder: { [weak self] in
            guard let self = self else { return [] }
            
            return [locationNameDeleteButton]
        }
    ).then {
        $0.placeholder = "입력해주세요"
        $0.styled(variant: .outlined)
    }
    
    // - Location link text field
    lazy var locationLinkLabel = UILabel().then {
        $0.text = "장소\n링크"
        $0.setTypo(.body2b)
        $0.textColor = .grey500
        $0.numberOfLines = 2
    }
    
    lazy var locationLinkDeleteButton = UIImageView(image: .imgXCircle).then {
        $0.contentMode = .scaleAspectFit
        $0.setSize(width: 20, height: 20)
        $0.layer.cornerRadius = 10
        $0.isUserInteractionEnabled = true
        $0.isHidden = true
    }
    
    lazy var locationLinkTextField = BaseTextField(
        suffixBuilder: { [weak self] in
            guard let self = self else { return [] }
            
            return [locationLinkDeleteButton]
        }
    ).then {
        $0.placeholder = "입력해주세요"
        $0.styled(variant: .outlined)
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
    
    // MARK: Setup
    override func setupHierarchy() {
        addSubview(navigationBar)
        
        addSubview(contentView)
        
        contentView.addSubview(header)
        
        contentView.addSubview(segment)
        
        contentView.addSubview(locationNameLabel)
        
        contentView.addSubview(locationNameTextField)
        
        contentView.addSubview(locationLinkLabel)
        
        contentView.addSubview(locationLinkTextField)
        
        contentView.addSubview(openGraphCard)
    }
    
    override func setupLayout() {
        navigationBar.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide.snp.top)
            $0.left.right.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom)
            $0.bottom.equalToSuperview()
            $0.left.right.equalToSuperview()
                .inset(GlobalViewConstant.pagePadding)
        }
        
        header.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.right.equalToSuperview()
        }
        
        segment.snp.makeConstraints {
            $0.top.equalTo(header.snp.bottom)
            $0.left.right.equalToSuperview()
        }
        
        locationNameLabel.snp.makeConstraints {
            $0.top.equalTo(segment.snp.bottom)
                .offset(FunnelConstant.spacingUnit * 4)
            $0.left.equalToSuperview()
            $0.width.equalTo(30)
        }
        
        locationNameTextField.snp.makeConstraints {
            $0.centerY.equalTo(locationNameLabel.snp.centerY)
            $0.left.equalTo(locationNameLabel.snp.right)
                .offset(8)
            $0.right.equalToSuperview()
        }
        
        locationLinkLabel.snp.makeConstraints {
            $0.top.equalTo(locationNameTextField.snp.bottom)
                .offset(FunnelConstant.spacingUnit * 2)
            $0.left.equalToSuperview()
            $0.width.equalTo(30)
        }
        
        locationLinkTextField.snp.makeConstraints {
            $0.centerY.equalTo(locationLinkLabel.snp.centerY)
            $0.left.equalTo(locationLinkLabel.snp.right)
                .offset(8)
            $0.right.equalToSuperview()
        }
        
        openGraphCard.snp.makeConstraints {
            $0.top.equalTo(locationLinkTextField.snp.bottom)
                .offset(FunnelConstant.spacingUnit)
            $0.left.equalToSuperview()
                .inset(32)
            $0.right.equalToSuperview()
        }
    }
}
