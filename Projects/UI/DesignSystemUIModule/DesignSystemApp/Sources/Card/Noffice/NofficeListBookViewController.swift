//
//  NofficeListBookViewController.swift
//  DesignSystem
//
//  Created by DOYEON LEE on 7/16/24.
//

import UIKit

import DesignSystem

import RxSwift
import SnapKit
import Then

class NofficeListBookViewController: UIViewController {
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
        items: Array(NofficeList.Status.allCases).map { $0.rawValue }
    ).then {
        $0.selectedSegmentIndex = 0
    }
    
    private let listView = NofficeList().then {
        $0.text = "팀원 리스트 제출"
    }
    
    // MARK: DisposeBag
    private let disposeBag = DisposeBag()
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupHierarchy()
        setupLayout()
        setupBind()
    }
    
    // MARK: Setup
    private func setupHierarchy() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(stackView)
        
        stackView.addArrangedSubview(stateSegmentedControl)
        
        stackView.addArrangedSubview(listView)
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
    
    private func setupBind() {
        stateSegmentedControl.rx.selectedSegmentIndex
            .map { NofficeList.Status.allCases[$0] }
            .subscribe(onNext: { [weak self] state in
                self?.listView.status = state
            })
            .disposed(by: disposeBag)
        
        listView.onTap
            .subscribe(onNext: { [weak self] _ in
                self?.listView.stateToggle()
            })
            .disposed(by: disposeBag)
    }
}
