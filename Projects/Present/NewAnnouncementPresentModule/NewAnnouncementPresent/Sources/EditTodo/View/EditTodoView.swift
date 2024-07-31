//
//  EditLocationView.swift
//  NewAnnouncementPresent
//
//  Created by DOYEON LEE on 7/22/24.
//

import UIKit

import DesignSystem
import Assets

import SnapKit
import Then

class EditTodoView: BaseView {
    // MARK: UI Constant
    
    // MARK: UI Component
    // - Navigation bar
    lazy var navigationBar = NofficeNavigationBar().then {
        $0.title = "할 일 추가"
    }
    
    // - Content view
    lazy var contentView = UIView()
    
    // - Title
    lazy var header = NofficeFunnelHeader().then {
        $0.funnelType = .newAnnouncement
        $0.title = "멤버들에게 할 일을 전달해봐요"
    }
    
    // - Todo collection view
    lazy var collectionView = CompositionalCollectionView()
    
    // - New todo text field
    lazy var newTodoTextField = BaseTextField().then {
        $0.placeholder = "할 일을 입력해주세요"
        $0.styled(variant: .plain, color: .blue)
        $0.layer.opacity = 0.0
    }
    
    // - New todo complete button
    lazy var newTodoCompleteButton = BaseButton {
        [
            UIImageView(image: .iconSend).then {
                $0.setSize(width: 28, height: 32)
                $0.contentMode = .scaleAspectFill
                $0.tintColor = .grey300
            }
        ]
    }.then {
        $0.styled(variant: .transparent, color: .ghost, size: .small)
        $0.layer.opacity = 0.0
    }
    
    // - Add todo button
    lazy var addTodoButton = BaseButton(
        contentsBuilder: {
            [
                UILabel().then {
                    $0.text = "새로운 투두"
                    $0.setTypo(.body1b)
                },
                UIImageView(image: .iconPlus).then {
                    $0.setSize(width: 22, height: 22)
                }
            ]
        }
    ).then {
        $0.styled(variant: .translucent, color: .green)
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
        $0.styled(variant: .fill, color: .green)
    }
    
    // MARK: Setup
    override func setupHierarchy() { 
        addSubview(navigationBar)
        
        addSubview(contentView)
        
        contentView.addSubview(header)
        
        contentView.addSubview(collectionView)
        
        contentView.addSubview(addTodoButton)
        
        contentView.addSubview(saveButton)
        
        contentView.addSubview(newTodoTextField)
        
        contentView.addSubview(newTodoCompleteButton)
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
        }
        
        header.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.right.equalToSuperview()
                .inset(GlobalViewConstant.pagePadding)     
        }
        
        saveButton.snp.makeConstraints {
            $0.left.right.equalToSuperview()
                .inset(GlobalViewConstant.pagePadding)
            $0.bottom.equalToSuperview()
                .inset(FunnelConstant.spacingUnit * 3)
        }
        
        addTodoButton.snp.makeConstraints {
            $0.left.right.equalToSuperview()
                .inset(GlobalViewConstant.pagePadding)
            $0.bottom.equalTo(saveButton.snp.top)
                .inset(-FunnelConstant.spacingUnit)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(header.snp.bottom)
            $0.bottom.equalTo(addTodoButton.snp.top)
            $0.left.right.equalToSuperview()
                .inset(FunnelConstant.additionalPadding)
        }
        
        newTodoCompleteButton.snp.makeConstraints {
            $0.bottom.equalTo(keyboardLayoutGuide.snp.top)
                .inset(-FunnelConstant.spacingUnit * 1.2)
            $0.right.equalToSuperview()
                .inset(GlobalViewConstant.pagePadding / 2)
        }
        
        newTodoTextField.snp.makeConstraints {
            $0.bottom.equalTo(keyboardLayoutGuide.snp.top)
                .inset(-FunnelConstant.spacingUnit)
            $0.left.equalToSuperview()
                .inset(GlobalViewConstant.pagePadding)
            $0.right.equalTo(newTodoCompleteButton.snp.left)
        }
    }
}
