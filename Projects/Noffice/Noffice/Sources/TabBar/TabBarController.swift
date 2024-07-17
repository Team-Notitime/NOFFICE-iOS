//
//  NofficeTabBarController.swift
//  Noffice
//
//  Created by DOYEON LEE on 7/10/24.
//

import UIKit

import HomePresent
import OrganizationPresent
import DesignSystem
import Assets

import RxSwift
import RxCocoa
import Then
import SnapKit

final class TabBarController: UITabBarController {
    var isHidden: Bool = false {
        didSet { self.announceTabItem.isHidden = tabBar.isHidden }
    }
    
    // MARK: UI Constant
    private lazy var announcementButtonSize: CGFloat = view.frame.width / 7
    
    // MARK: UI Component
    private lazy var homeTabImage = UIImageView(image: .iconHome).then {
        $0.contentMode = .scaleAspectFit
    }
    
    private lazy var homeTabItem = UIView().then {
        $0.backgroundColor = .clear
    }
    
    private lazy var announceTabItem = UIView().then {
        $0.backgroundColor = .green500
        $0.layer.cornerRadius = announcementButtonSize / 2
        $0.clipsToBounds = true

        let imageView = UIImageView(image: .iconPlus).then {
            $0.contentMode = .scaleAspectFit
            $0.tintColor = .fullWhite
        }

        $0.addSubview(imageView)

        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10)
        }
    }
    
    private lazy var groupTabImage = UIImageView(image: .iconGroup).then {
        $0.contentMode = .scaleAspectFit
    }
    
    private lazy var groupTabItem = UIView().then {
        $0.backgroundColor = .clear
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
        self.view.backgroundColor = .grey50
        self.tabBar.backgroundColor = .grey50
        self.tabBar.tintColor = Self.selectedColor
        self.tabBar.unselectedItemTintColor = Self.unselectedColor
    }
    
    /// Assign view controllers that are currently visible to the TabBar.
    private func setupTabBarControllers() {
        let controllers: [UIViewController] = [
            HomeTabViewController(),
            OrganizationTabViewController()
        ]
        self.setViewControllers(controllers, animated: false)
    }
    
    /// Sets up the constraints for custom tab bar items.
    private func setupTabBarItems() {
        if let homeTabBarItemView = self.findTabBarItemView(at: TabBarItem.home.tag) {
            homeTabBarItemView.tag = TabBarItem.home.tag
            homeTabBarItemView.addSubview(homeTabItem)
            
            homeTabItem.snp.makeConstraints {
                $0.top.bottom.equalToSuperview()
                $0.width.equalToSuperview().multipliedBy(1.2)
                $0.centerX.equalToSuperview().multipliedBy(0.8)
            }
            
            homeTabItem.addSubview(homeTabImage)
            homeTabImage.snp.makeConstraints { make in
                make.centerX.centerY.equalToSuperview()
                make.width.height.equalTo(28)
            }
        }
        
        announceTabItem.tag = TabBarItem.announce.tag
        self.view.addSubview(announceTabItem)
        announceTabItem.snp.makeConstraints { make in
            make.centerY.equalTo(tabBar.snp.top)
            make.centerX.equalToSuperview()
            make.height.width.equalTo(announcementButtonSize)
        }
        
        if let groupTabBarItemView = self.findTabBarItemView(at: TabBarItem.group.tag) {
            groupTabBarItemView.tag = TabBarItem.group.tag
            groupTabBarItemView.addSubview(groupTabItem)
            
            groupTabItem.snp.makeConstraints {
                $0.top.bottom.equalToSuperview()
                $0.width.equalToSuperview().multipliedBy(1.2)
                $0.centerX.equalToSuperview().multipliedBy(1.2)
            }
            
            groupTabItem.addSubview(groupTabImage)
            groupTabImage.snp.makeConstraints { make in
                make.centerX.centerY.equalToSuperview()
                make.width.height.equalTo(28)
            }
        }
    }
    
    /// Set up bindings for button in TabBarItem
    private func setupBind() {
        let homeapGesture = UITapGestureRecognizer()
        homeTabItem.addGestureRecognizer(homeapGesture)
        
        homeapGesture.rx.event
            .bind { [weak self] _ in
                self?.selectedIndex = TabBarItem.home.tag
                self?.updateTabBarItemColor(selectedItem: .home)
            }
            .disposed(by: disposeBag)
        
        let announceTapGesture = UITapGestureRecognizer()
        announceTabItem.addGestureRecognizer(announceTapGesture)

        announceTapGesture.rx.event
            .bind { [weak self] _ in
                // TODO
            }
            .disposed(by: disposeBag)
        
        let groupTapGesture = UITapGestureRecognizer()
        groupTabItem.addGestureRecognizer(groupTapGesture)
        
        groupTapGesture.rx.event
            .bind { [weak self] _ in
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
                UIView.animate(withDuration: 0.35) {
                    tabBarItemView.tintColor = isSelected
                    ? Self.selectedColor
                    : Self.unselectedColor
                }
            }
        }
    }
    
    // MARK: Helper method
    /// Find and return the UIView that matches the TabBarItem.
    private func findTabBarItemView(at index: Int) -> UIView? {
        let tabBarButtons = self.tabBar.subviews.filter { $0 is UIView }
        if index < tabBarButtons.count {
            return tabBarButtons.sorted {
                $0.frame.minX < $1.frame.minX
            }[index]
        }
        return nil
    }
}

extension TabBarController: UIPopoverPresentationControllerDelegate {
    public func adaptivePresentationStyle(
        for controller: UIPresentationController,
        traitCollection: UITraitCollection) -> UIModalPresentationStyle {
            return .none
    }
}

extension TabBarController {
    static let selectedColor: UIColor = .green500
    static let unselectedColor: UIColor = .grey300
}
