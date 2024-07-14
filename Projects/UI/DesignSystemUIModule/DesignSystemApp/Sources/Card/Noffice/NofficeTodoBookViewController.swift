//
//  NofficeTodoViewController.swift
//  DesignSystemApp
//
//  Created by DOYEON LEE on 7/14/24.
//

import UIKit

import DesignSystem

import RxSwift
import SnapKit
import Then

class NofficeTodoBookViewController: UIViewController {
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
        items: Array(NofficeTodo.Status.allCases).map { $0.rawValue }
    ).then {
        $0.selectedSegmentIndex = 0
    }
    
    private let todoView = NofficeTodo().then {
        $0.text = "팀원 리스트 제출"
    }
    
    private let longTodoView = NofficeTodo().then {
        $0.text = "투두가 길어지면 어떻게 하면 좋을까용 이렇게 하면 될 것 같습니다...투두가 길어지면 어떻게 하면 좋을까용 이렇게 하면 될 것 같습니다..."
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
        
        stackView.addArrangedSubview(todoView)
        stackView.addArrangedSubview(longTodoView)
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
            .map { NofficeTodo.Status.allCases[$0] }
            .subscribe(onNext: { [weak self] state in
                self?.todoView.status = state
            })
            .disposed(by: disposeBag)
        
        stateSegmentedControl.rx.selectedSegmentIndex
            .map { NofficeTodo.Status.allCases[$0] }
            .subscribe(onNext: { [weak self] state in
                self?.longTodoView.status = state
            })
            .disposed(by: disposeBag)
        
        todoView.onTap
            .subscribe(onNext: { [weak self] _ in
                self?.todoView.stateToggle()
            })
            .disposed(by: disposeBag)
        
        longTodoView.onTap
            .subscribe(onNext: { [weak self] _ in
                self?.longTodoView.stateToggle()
            })
            .disposed(by: disposeBag)
    }
}