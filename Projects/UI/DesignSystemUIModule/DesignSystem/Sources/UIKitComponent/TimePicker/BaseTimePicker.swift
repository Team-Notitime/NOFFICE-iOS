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
    func updateTime(hour: Int, minute: Int, isPM: Bool) {
        self.selectedDateComponent = DateComponents(
            hour: hour + (isPM ? 12 : 0),
            minute: minute
        )
        
        updateTimePicker()
    }
}

public class BaseTimePicker: UIView {
    // MARK: Event
    private let _onChangeSelectedTime = PublishSubject<DateComponents>()
    public var onChangeSelectedTime: Observable<DateComponents> {
        return _onChangeSelectedTime.asObservable()
    }
    
    public var selectedTime: Binder<DateComponents?> {
        return Binder(self) { timePicker, timeComponents in
            guard let timeComponents = timeComponents
            else {
                timePicker.selectedDateComponent = nil
                timePicker.updateTimePicker()
                return
            }
            
            timePicker.selectedDateComponent = timeComponents
            timePicker.updateTimePicker()
        }
    }
    
    // MARK: State
    private var selectedDateComponent: DateComponents?
    
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
        var components = selectedDateComponent ?? DateComponents(hour: 0, minute: 0)
        components.hour = ((components.hour ?? 0) + 1) % 24
        selectedDateComponent = components
        updateTimePicker()
    }

    private func decrementHour() {
        var components = selectedDateComponent ?? DateComponents(hour: 0, minute: 0)
        components.hour = ((components.hour ?? 0) - 1 + 24) % 24
        selectedDateComponent = components
        updateTimePicker()
    }

    private func incrementMinute() {
        var components = selectedDateComponent ?? DateComponents(hour: 0, minute: 0)
        components.minute = ((components.minute ?? 0) + 1) % 60
        selectedDateComponent = components
        updateTimePicker()
    }

    private func decrementMinute() {
        var components = selectedDateComponent ?? DateComponents(hour: 0, minute: 0)
        components.minute = (((components.minute ?? 0) - 1 + 60) % 60)
        selectedDateComponent = components
        updateTimePicker()
    }

    private func toggleAmPm() {
        var components = selectedDateComponent ?? DateComponents(hour: 0, minute: 0)
        let hour = components.hour ?? 0
        if isPM {
            components.hour = hour % 12
        } else {
            components.hour = (hour % 12) + 12
        }
//        print(components)
        selectedDateComponent = components
        updateTimePicker()
    }
    
    private func updateTimePicker() {
        let hour = selectedDateComponent?.hour ?? 0
        print(hour)
        let minute = selectedDateComponent?.minute ?? 0
        let adjustedHour = hour % 12 == 0 ? 12 : hour % 12
        isPM = hour >= 12

        // Update the labels (UI logic, for reference only)
        hourLabel.text = String(format: "%d", adjustedHour)
        minuteLabel.text = String(format: "%02d", minute)
        amPmLabel.text = isPM ? "PM" : "AM"
        
        // Notify the observers
        if let selectedDateComponent = selectedDateComponent {
            _onChangeSelectedTime.onNext(selectedDateComponent)
        }
    }
}
