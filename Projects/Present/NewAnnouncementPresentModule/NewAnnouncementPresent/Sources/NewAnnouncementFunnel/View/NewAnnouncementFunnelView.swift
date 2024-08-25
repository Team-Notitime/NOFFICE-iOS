//
//  NewAnnouncementFunnelView.swift
//  NewAnnouncementPresent
//
//  Created by DOYEON LEE on 7/22/24.
//

import UIKit

import DesignSystem
import Assets

import SnapKit
import Then

public class NewAnnouncementFunnelView: BaseView {
    // MARK: Data
    let pages = Array(NewAnnouncementFunnelPage.allCases)
    
    // MARK: UI Component
    // - Navigation bar
    lazy var navigationBar = NofficeNavigationBar().then {
        $0.title = "노티 등록"
    }
    
    // - Paginable bar
    lazy var paginableView = PaginableView(
        pages: pages,
        firstPage: .selectOrganization
    ).then {
        $0.gestureScrollEnabled = false
    }
    
    // - Has leader role organization dialog
    lazy var hasLeaderRoleOrganizationDialog = BaseDialog(
        contentsBuilder: {
            [
                UILabel().then {
                    $0.text = "참여한 그룹이 없어요"
                }
            ]
        }
    ).then {
        $0.styled()
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

extension NewAnnouncementFunnelPage: Paginable {
    var viewController: UIViewController {
        switch self {
        case .selectOrganization:
            return SelectOrganizationPageViewController()
        case .editContents:
            return EditContentsPageViewController()
        case .complete:
            return CompletePageViewController()
        }
    }
}
