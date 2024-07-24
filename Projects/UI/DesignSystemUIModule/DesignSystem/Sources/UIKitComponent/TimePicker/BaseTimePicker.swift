//
//  BaseTimePicker.swift
//  DesignSystemApp
//
//  Created by DOYEON LEE on 7/24/24.
//

import UIKit

import RxSwift
import Then
import SnapKit

/// Extension for setting the initial time
public extension BaseTimePicker {
    func setTime(hour: Int, minute: Int, isPM: Bool) {
        self.selectedHour = hour
        self.selectedMinute = minute
        self.isPM = isPM
        updateTimePicker()
    }
}

public class BaseTimePicker: UIView {
    // MARK: Event
    private let _onChangeSelectedTime = PublishSubject<DateComponents>()
    public var onChangeSelectedTime: Observable<DateComponents> {
        return _onChangeSelectedTime.asObservable()
    }
    
    // MARK: State
    private var selectedHour: Int = 0
    private var selectedMinute: Int = 0
    private var isPM: Bool = false
    
    // MARK: UI Component
    private lazy var hourLabel = UILabel().then {
        $0.textAlignment = .center
        $0.setTypo(.body0b)
        $0.textColor = .grey800
    }
    
    private lazy var minuteLabel = UILabel().then {
        $0.textAlignment = .center
        $0.setTypo(.body0b)
        $0.textColor = .grey800
    }
    
    private lazy var amPmLabel = UILabel().then {
        $0.textAlignment = .center
        $0.setTypo(.body0b)
        $0.textColor = .grey800
    }
    
    private lazy var hourUpButton = UIButton(type: .system).then {
        $0.setImage(.iconChevronUp, for: .normal)
        $0.tintColor = .grey500
    }
    
    private lazy var hourDownButton = UIButton(type: .system).then {
        $0.setImage(.iconChevronDown, for: .normal)
        $0.tintColor = .grey500
    }
    
    private lazy var minuteUpButton = UIButton(type: .system).then {
        $0.setImage(.iconChevronUp, for: .normal)
        $0.tintColor = .grey500
    }
    
    private lazy var minuteDownButton = UIButton(type: .system).then {
        $0.setImage(.iconChevronDown, for: .normal)
        $0.tintColor = .grey500
    }
    
    private lazy var amPmUpButton = UIButton(type: .system).then {
        $0.setImage(.iconChevronUp, for: .normal)
        $0.tintColor = .grey500
    }
    
    private lazy var amPmDownButton = UIButton(type: .system).then {
        $0.setImage(.iconChevronDown, for: .normal)
        $0.tintColor = .grey500
    }
    
    // MARK: DisposeBag
    private let disposeBag = DisposeBag()
    
    // MARK: Initializer
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupHierarchy()
        setupLayout()
        setupBind()
        updateTimePicker()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Setup
    private func setupHierarchy() {
        addSubview(hourLabel)
        
        addSubview(hourUpButton)
        
        addSubview(hourDownButton)
        
        addSubview(minuteLabel)
        
        addSubview(minuteUpButton)
        
        addSubview(minuteDownButton)
        
        addSubview(amPmLabel)
        
        addSubview(amPmUpButton)
        
        addSubview(amPmDownButton)
    }
    
    private func setupLayout() {
        hourUpButton.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.centerX.equalTo(hourLabel)
        }
        
        hourLabel.snp.makeConstraints {
            $0.top.equalTo(hourUpButton.snp.bottom).offset(8)
            $0.centerX.equalToSuperview().multipliedBy(0.5)
        }
        
        hourDownButton.snp.makeConstraints {
            $0.top.equalTo(hourLabel.snp.bottom).offset(8)
            $0.centerX.equalTo(hourLabel)
            $0.bottom.equalToSuperview()
        }
        
        minuteUpButton.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.centerX.equalTo(minuteLabel)
        }
        
        minuteLabel.snp.makeConstraints {
            $0.top.equalTo(minuteUpButton.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
        }
        
        minuteDownButton.snp.makeConstraints {
            $0.top.equalTo(minuteLabel.snp.bottom).offset(8)
            $0.centerX.equalTo(minuteLabel)
            $0.bottom.equalToSuperview()
        }
        
        amPmUpButton.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.centerX.equalTo(amPmLabel)
        }
        
        amPmLabel.snp.makeConstraints {
            $0.top.equalTo(amPmUpButton.snp.bottom).offset(8)
            $0.centerX.equalToSuperview().multipliedBy(1.5)
        }
        
        amPmDownButton.snp.makeConstraints {
            $0.top.equalTo(amPmLabel.snp.bottom).offset(8)
            $0.centerX.equalTo(amPmLabel)
            $0.bottom.equalToSuperview()
        }
    }
    
    private func setupBind() {
        hourUpButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.incrementHour()
            })
            .disposed(by: disposeBag)
        
        hourDownButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.decrementHour()
            })
            .disposed(by: disposeBag)
        
        minuteUpButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.incrementMinute()
            })
            .disposed(by: disposeBag)
        
        minuteDownButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.decrementMinute()
            })
            .disposed(by: disposeBag)
        
        amPmUpButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.toggleAmPm()
            })
            .disposed(by: disposeBag)
        
        amPmDownButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.toggleAmPm()
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: Update
    private func incrementHour() {
        selectedHour = (selectedHour % 12) + 1
        updateTimePicker()
    }
    
    private func decrementHour() {
        selectedHour = (selectedHour - 1 + 12) % 12
        if selectedHour == 0 {
            selectedHour = 12
        }
        updateTimePicker()
    }
    
    private func incrementMinute() {
        selectedMinute = (selectedMinute + 1) % 60
        updateTimePicker()
    }
    
    private func decrementMinute() {
        selectedMinute = (selectedMinute - 1 + 60) % 60
        updateTimePicker()
    }
    
    private func toggleAmPm() {
        isPM.toggle()
        updateTimePicker()
    }
    
    private func updateTimePicker() {
        hourLabel.text = String(format: "%d", selectedHour)
        minuteLabel.text = String(format: "%02d", selectedMinute)
        amPmLabel.text = isPM ? "PM" : "AM"
        
        let components = DateComponents(hour: selectedHour + (isPM ? 12 : 0), minute: selectedMinute)
        _onChangeSelectedTime.onNext(components)
    }
}
