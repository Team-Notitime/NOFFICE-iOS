//
//  NewOrganizationView.swift
//  OrganizationPresent
//
//  Created by DOYEON LEE on 7/17/24.
//

import UIKit

import DesignSystem
import Assets

import SnapKit
import Then
import Swinject

public class NewOrganizationFunnelView: BaseView {
    // MARK: Data
    let pages = Array(NewOrganizationFunnelPage.allCases)
    
    // MARK: UI Component
    // - Navigation bar
    lazy var navigationBar = NofficeNavigationBar()
    
    // - Paginable bar
    lazy var paginableView = PaginableView(
        pages: pages,
        firstPage: .name
    ).then {
        $0.gestureScrollEnabled = false
    }
  
    lazy var unsavedChangedsDialog = BaseDialog {
      DialogContentView(
        icon: .imgNottiBang,
        title: "완료하지 않고 나갈 건가요?",
        message: "지금까지의 작성 내용이 사라집니다."
      )
    } buttonBuilder: {
      [
        goHomeButton,
        continueButton
      ]
    }.then {
      $0.styled(
        variant: .overlay,
        shape: .round
      )
    }
    
    lazy var goHomeButton = BaseButton(
        contentsBuilder: {
            [
                UILabel().then {
                    $0.text = "나가기"
                    $0.setTypo(.body1b)
                }
            ]
        }
    ).then {
        $0.styled(
            variant: .fill,
            color: .ghost,
            size: .medium
        )
    }
    
    lazy var continueButton = BaseButton(
      contentsBuilder: {
        [
          UILabel().then {
            $0.text = "이어서 완료하기"
            $0.setTypo(.body1b)
          }
        ]
      }
    ).then {
      $0.styled(
        variant: .fill,
        color: .green,
        size: .medium
      )
    }
    
    // MARK: Setup
    public override func setupHierarchy() {
        addSubview(navigationBar)
        
        addSubview(paginableView)
    }
    
    public override func setupLayout() { 
        navigationBar.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.left.right.equalToSuperview()
        }
        
        paginableView.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom)
            $0.left.right.bottom.equalToSuperview()
        }
    }
}

// MARK: - DisplayModel
extension NewOrganizationFunnelPage: Paginable {
    var viewController: UIViewController {
        switch self {
        case .name:
            return NewOrganizationNamePageViewController()
        case .category:
            return NewOrganizationCategoryPageViewController()
        case .image:
            return NewOrganizationImagePageViewController()
        case .endDate:
            return NewOrganizationDatePageViewController()
        case .promotion:
            return NewOrganizationPromotionPageViewController()
        case .complete:
          return NewOrganizationCompletePageViewController()
        }
    }
}
