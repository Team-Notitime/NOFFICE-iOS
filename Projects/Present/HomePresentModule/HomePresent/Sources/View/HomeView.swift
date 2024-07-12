//
//  HomeView.swift
//  HomePresent
//
//  Created by DOYEON LEE on 7/13/24.
//

import UIKit

import DesignSystem
import Assets

import SnapKit
import Then

public class HomeView: BaseView {
    enum Page: CaseIterable, Identifiable, PageType {
        case noti
        case todo
        
        var krName: String {
            switch self {
            case .noti: return "노티"
            case .todo: return "투두"
            }
        }
        
        var id: String {
            return String(describing: "\(self))")
        }
        
        var viewController: UIViewController {
            switch self {
            case .noti:
                let vc = UIViewController()
                vc.view.backgroundColor = .blue100
                return vc
            case .todo:
                let vc = UIViewController()
                vc.view.backgroundColor = .yellow100
                return vc
            }
        }
    }
    
    // MARK: UI component
    lazy var segmentControl = BaseSegmentControl(
        source: Page.allCases,
        itemBuilder: { option in
            UILabel().then {
                $0.text = "\(option.krName)"
                $0.setTypo(.heading3)
                $0.textAlignment = .center
            }
        }
    ).then {
        $0.styled(variant: .underline)
    }
    
    lazy var pageViewController = PageViewController<Page>(
        pages: Page.allCases,
        firstPage: Page.noti
    )
    
    // MARK: Setup
    public override func setupHierarchy() {
        // segmentControl
        addSubview(segmentControl)
        
        // pageViewController
        addSubview(pageViewController.view)
    }
    
    public override func setupLayout() { 
        segmentControl.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide.snp.top)
            $0.leading.equalToSuperview().offset(pagePadding)
            $0.width.equalToSuperview().multipliedBy(0.4)
            $0.height.equalTo(60)
        }
        
        pageViewController.view.snp.makeConstraints {
            $0.top.equalTo(segmentControl.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    public override func setupBind() { 
        pageViewController.onMove
            .bind(to: self.segmentControl.selectedOption)
            .disposed(by: disposeBag)
        
        segmentControl.onChange
            .bind(to: self.pageViewController.selectedPage)
            .disposed(by: disposeBag)
    }
    
}
