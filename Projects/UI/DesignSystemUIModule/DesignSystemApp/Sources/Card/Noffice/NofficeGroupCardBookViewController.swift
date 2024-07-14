//
//  NofficeGroupCardBookViewController.swift
//  DesignSystemApp
//
//  Created by DOYEON LEE on 7/14/24.
//

import UIKit

import DesignSystem

import RxSwift
import SnapKit
import Then

class NofficeGroupCardBookViewController: UIViewController {
    // MARK: UI Components
    private lazy var scrollView = UIScrollView()
    private lazy var contentView = UIView()
    private lazy var stackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 16
        $0.alignment = .fill
        $0.distribution = .fill
    }
    
    private lazy var stateSegmentedControl = UISegmentedControl(
        items: Array(NofficeGroupCard.State.allCases).map { $0.rawValue }
    ).then {
        $0.selectedSegmentIndex = 0
    }
    
    private let groupCard = NofficeGroupCard()
    
    // MARK: DisposeBag
    private let disposeBag = DisposeBag()
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupHierarchy()
        setupLayout()
        setupProperty()
        setupBind()
    }
    
    // MARK: Setup
    private func setupHierarchy() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(stackView)
        
        stackView.addArrangedSubview(stateSegmentedControl)
        stackView.addArrangedSubview(groupCard)
    }
    
    private func setupLayout() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalTo(scrollView)
        }
        
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(16)
        }
    }
    
    private func setupProperty() {
        groupCard.titleText = "5차 세션 : 최종 팀빌딩"
        groupCard.dateText = "2024.06.29(토) 14:00"
        groupCard.locationText = "ZEP"
    }
    
    private func setupBind() {
        stateSegmentedControl.rx.selectedSegmentIndex
            .map { NofficeGroupCard.State.allCases[$0] }
            .subscribe(onNext: { [weak self] state in
                self?.updateGroupCardState(state)
            })
            .disposed(by: disposeBag)
    }

    private func updateGroupCardState(_ state: NofficeGroupCard.State) {
        groupCard.state = state
    }
}
