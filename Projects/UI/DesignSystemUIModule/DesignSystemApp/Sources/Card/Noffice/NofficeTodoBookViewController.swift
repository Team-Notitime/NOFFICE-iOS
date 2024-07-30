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
    // MARK: Data
    private let todoModel = TodoModel(id: 1, text: "팀원 리스트 제출")
    
    private let longTodoModel = TodoModel(
        id: 1,
        text: "투두가 길어지면 어떻게 하면 좋을까용 이렇게 하면 될 것 같습니다...투두가 길어지면 어떻게 하면 좋을까용 이렇게 하면 될 것 같습니다..."
    )
    
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
        items: Array(NofficeTodo<TodoModel>.Status.allCases).map { $0.rawValue }
    ).then {
        $0.selectedSegmentIndex = 0
    }
    
    private lazy var todoView = NofficeTodo(option: todoModel).then {
        $0.text = todoModel.text
    }
    
    private lazy var longTodoView = NofficeTodo(option: longTodoModel).then {
        $0.text = longTodoModel.text
    }
    
    private lazy var todoGroupLabel = UILabel().then {
        $0.text = "With RadioGroup (+ grid)"
        $0.setTypo(.body1b)
        $0.textAlignment = .center
    }
    
    private lazy var todoGroup = BaseCheckBoxGroup(
        source: TodoModel.factory(Array(0...3))
    ) { option in
        NofficeTodo<TodoModel>(option: option).then {
            $0.text = "\(option.text) \(option.id)"
            $0.automaticToggle = true
        }
    }.then {
        $0.gridStyled(columns: 1, verticalSpacing: 16, horizontalSpacing: 16)
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
        stackView.addArrangedSubview(todoGroupLabel)
        stackView.addArrangedSubview(todoGroup)
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
            .observe(on: MainScheduler.asyncInstance)
            .subscribe(onNext: { [weak self] state in
                self?.todoView.status = state
            })
            .disposed(by: disposeBag)
        
        stateSegmentedControl.rx.selectedSegmentIndex
            .map { NofficeTodo.Status.allCases[$0] }
            .observe(on: MainScheduler.asyncInstance)
            .subscribe(onNext: { [weak self] state in
                self?.longTodoView.status = state
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - Display model
extension NofficeTodoBookViewController {
    struct TodoModel: Identifiable, Equatable {
        let id: Int
        let text: String
        
        static func factory(_ options: [Int]) -> [TodoModel] {
            return options.map { TodoModel(id: $0, text: "Noffice Todo") }
        }
    }
}
