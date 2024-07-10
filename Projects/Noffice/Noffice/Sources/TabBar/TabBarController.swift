//
//  NofficeTabBarController.swift
//  Noffice
//
//  Created by DOYEON LEE on 7/10/24.
//

import UIKit

import Assets

import RxSwift
import RxCocoa
import Then
import SnapKit

final class TabBarController: UITabBarController {
    
    var isHidden: Bool = false {
        didSet { self.announceButton.isHidden = tabBar.isHidden }
    }
    
    // MARK: Component
    private lazy var homeButton = UIButton().then {
        $0.setImage(.iconHome, for: .normal)
        $0.contentMode = .scaleAspectFit
    }
    
    private lazy var announceButton = UIButton().then {
        $0.backgroundColor = .green
        $0.setImage(UIImage(systemName: "plus"), for: .normal)
        $0.contentMode = .scaleAspectFit
        $0.imageView?.tintColor = .white
        $0.layer.cornerRadius = view.frame.width / 12
    }
    
    private lazy var groupButton = UIButton().then {
        $0.setImage(.iconGroup, for: .normal)
        $0.contentMode = .scaleAspectFit
    }
    
    // MARK: DisposeBag
    private let disposeBag = DisposeBag()
    
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabBarStyle()
        setupTabBarControllers()
        setupTabBarItems()
        setupBind()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let selectedTab = TabBarItem(rawValue: self.selectedIndex) {
            updateTabBarItemColor(selectedItem: selectedTab)
        }
    }
    
    // MARK: Setup
    /// Style the tab bar
    private func setupTabBarStyle() {
        self.view.backgroundColor = .systemBackground
        self.tabBar.backgroundColor = .systemBackground
        self.tabBar.tintColor = .systemBlue
        self.tabBar.unselectedItemTintColor = .gray
    }
    
    /// Assign view controllers that are currently visible to the TabBar.
    private func setupTabBarControllers() {
        let controllers: [UIViewController] = [ViewController(), SecondViewController()]
        self.setViewControllers(controllers, animated: false)
    }
    
    /// Sets up the constraints for custom tab bar items.
    private func setupTabBarItems() {
        if let homeTabBarItemView = self.findTabBarItemView(at: TabBarItem.home.tag) {
            homeTabBarItemView.tag = TabBarItem.home.tag
            homeTabBarItemView.addSubview(homeButton)
            
            homeButton.snp.makeConstraints {
                $0.top.bottom.equalToSuperview()
                $0.width.equalToSuperview().multipliedBy(1.2)
                $0.centerX.equalToSuperview().multipliedBy(0.8)
            }
        }
        
        announceButton.tag = TabBarItem.announce.tag
        self.view.addSubview(announceButton)
        announceButton.snp.makeConstraints { make in
            make.centerY.equalTo(tabBar.snp.top)
            make.centerX.equalToSuperview()
            make.height.width.equalTo(view.frame.width / 6)
        }
        
        if let groupTabBarItemView = self.findTabBarItemView(at: TabBarItem.group.tag) {
            groupTabBarItemView.tag = TabBarItem.group.tag
            groupTabBarItemView.addSubview(groupButton)
            
            groupButton.snp.makeConstraints {
                $0.top.bottom.equalToSuperview()
                $0.width.equalToSuperview().multipliedBy(1.2)
                $0.centerX.equalToSuperview().multipliedBy(1.2)
            }
        }
    }
    
    /// Set up bindings for button in TabBarItem
    private func setupBind() {
        homeButton.rx.tap
            .bind { [weak self] in
                self?.selectedIndex = TabBarItem.home.tag
                self?.updateTabBarItemColor(selectedItem: .home)
            }
            .disposed(by: disposeBag)
        
        announceButton.rx.tap
            .bind { [weak self] in
                // TODO: Implement announce button action (show sheet or navigation)
//                self?.selectedIndex = TabBarItem.announce.tag
            }
            .disposed(by: disposeBag)
        
        groupButton.rx.tap
            .bind { [weak self] in
                self?.selectedIndex = TabBarItem.group.tag
                self?.updateTabBarItemColor(selectedItem: .group)
            }
            .disposed(by: disposeBag)
    }
    
    /// Set selected color to the TabBarItem
    private func updateTabBarItemColor(selectedItem: TabBarItem) {
        for item in TabBarItem.allCases {
            if let tabBarItemView = self.findTabBarItemView(at: item.tag) {
                let isSelected = tabBarItemView.tag == selectedItem.tag
                UIView.animate(withDuration: 0.2) {
                    tabBarItemView.tintColor = isSelected ? .systemBlue : .gray
                }
            }
        }
    }
    
    // MARK: Helper method
    /// Find and return the UIView that matches the TabBarItem.
    private func findTabBarItemView(at index: Int) -> UIView? {
        let tabBarButtons = self.tabBar.subviews.filter { $0 is UIControl }
        if index < tabBarButtons.count {
            return tabBarButtons.sorted {
                $0.frame.minX < $1.frame.minX
            }[index]
        }
        return nil
    }
}

extension TabBarController: UIPopoverPresentationControllerDelegate {
    public func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return .none
    }
}
