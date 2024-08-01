//
//  BaseCalendar.swift
//  DesignSystemApp
//
//  Created by DOYEON LEE on 7/19/24.
//

import UIKit

import Assets

import RxSwift
import Then
import SnapKit

/// Extension for set theme
public extension BaseCalendar {
    func styled(
        color: BasicCalendarCellColor = .green,
        shape: BasicCalendarCellShape = .round
    ) {
        self.cellColor = color
        self.cellShape = shape
    }
}

public extension BaseCalendar {
    var onChangeSelectedDate: Observable<Date> {
        return _onChangeSelectedDate.asObservable()
    }
    
    var selectedDate: Binder<Date?> {
        return Binder(self) { calendar, date in
            guard let date = date else {
                calendar.selectedDay = nil

                calendar.updateSelectedDay()
                return
            }
            
            let calendarInstance = Calendar.current
            let selectedMonth = calendarInstance.dateComponents([.year, .month], from: date)
            let currentMonthComponents = calendarInstance.dateComponents(
                [.year, .month],
                from: calendar.currentMonth
            )
            
            // If the selected date is not in the current month, change the month
            if selectedMonth != currentMonthComponents {
                calendar.currentMonth = calendarInstance
                    .date(from: selectedMonth) ?? calendar.currentMonth
                calendar.updateCalendar()
            }
            
            calendar.selectedDay = calendar.days.first { $0.date == date }
            
            calendar.updateSelectedDay()
        }
    }
}

public class BaseCalendar: UIView {
    // MARK: Event
    private let _onChangeSelectedDate = PublishSubject<Date>()
    
    // MARK: State
    private var previousDateDisabled: Bool = false
    
    private var currentMonth = Date()
    
    private var selectedDay: CalendarDay?
    
    // MARK: Data
    private var days: [CalendarDay] = []
    
    // MARK: Theme
    private var cellColor: BasicCalendarCellColor = .green
    
    private var cellShape: BasicCalendarCellShape = .round
    
    // MARK: UI Constant
    private static let Cellspacing: CGFloat = 8
    
    // MARK: UI Component
    private lazy var headerView = UIView()
    
    private lazy var monthLabel = UILabel().then {
        $0.textAlignment = .center
        $0.setTypo(.body0b)
        $0.textColor = .grey800
    }
    
    private lazy var previousButton = UIButton(type: .system).then {
        $0.setImage(.iconChevronLeft, for: .normal)
        $0.tintColor = .grey500
    }
    
    private lazy var nextButton = UIButton(type: .system).then {
        $0.setImage(.iconChevronRight, for: .normal)
        $0.tintColor = .grey500
    }
    
    private lazy var weekdayStackView = UIStackView().then { stackView in
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = Self.Cellspacing
        let weekdays = ["일", "월", "화", "수", "목", "금", "토"]
        weekdays.forEach { day in
            let label = UILabel().then {
                $0.text = day
                $0.textAlignment = .center
                $0.font = UIFont.systemFont(ofSize: 14)
            }
            stackView.addArrangedSubview(label)
        }
    }
    
    private lazy var calendarCollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout()
    ).then {
        $0.backgroundColor = .white
        $0.register(BaseCalendarCell.self, forCellWithReuseIdentifier: "CalendarCell")
        $0.dataSource = self
        $0.delegate = self
    }
    
    // MARK: DisposeBag
    private let disposeBag = DisposeBag()
    
    // MARK: Initializer
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupHierarchy()
        setupLayout()
        setupBind()
        updateCalendar()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public init(
        previousDateDisabled: Bool = false
    ) {
        super.init(frame: .zero)
        
        self.previousDateDisabled = previousDateDisabled
        
        if previousDateDisabled {
            previousButton.isEnabled = false
        }
        
        setupHierarchy()
        setupLayout()
        setupBind()
        updateCalendar()
    }
    
    // MARK: Setup
    private func setupHierarchy() {
        addSubview(headerView)
        
        headerView.addSubview(monthLabel)
        headerView.addSubview(previousButton)
        headerView.addSubview(nextButton)
        
        addSubview(weekdayStackView)
        addSubview(calendarCollectionView)
    }
    
    private func setupLayout() {
        headerView.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
        }

        monthLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview()
                .inset(24)
            $0.centerX.equalToSuperview()
        }

        previousButton.snp.makeConstraints {
            $0.centerY.equalTo(monthLabel.snp.centerY)
            $0.right.equalTo(monthLabel.snp.left)
                .offset(-8)
            $0.width.equalTo(34)
        }

        nextButton.snp.makeConstraints {
            $0.centerY.equalTo(monthLabel.snp.centerY)
            $0.left.equalTo(monthLabel.snp.right)
                .offset(8)
            $0.width.equalTo(34)
        }

        weekdayStackView.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(30)
        }

        calendarCollectionView.snp.makeConstraints {
            $0.top.equalTo(weekdayStackView.snp.bottom)
            $0.left.right.bottom.equalToSuperview()
        }
    }
    
    private func setupBind() {
        previousButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.changeMonth(by: -1)
            })
            .disposed(by: disposeBag)
        
        nextButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.changeMonth(by: 1)
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: Update
    private func updateSelectedDay() {
        guard let selectedDay = selectedDay else {
            // If selectedDay is nil, set it to today's date
            let today = Date()
            currentMonth = today

            updateCalendar()
            return
        }

        let calendar = Calendar.current
        let selectedMonth = calendar.dateComponents([.year, .month], from: selectedDay.date)
        let currentMonthComponents = calendar.dateComponents([.year, .month], from: currentMonth)

        // Check if the selected day is in the current month
        if selectedMonth != currentMonthComponents {
            // Change to the month of the selected day
            currentMonth = calendar.date(from: selectedMonth) ?? currentMonth
            updateCalendar()
        }

        // Find the index of the selected day
        if let index = days.firstIndex(where: { $0.date == selectedDay.date }) {
            // Update the collection view to reflect the selection
            calendarCollectionView.reloadData()
            calendarCollectionView.selectItem(
                at: IndexPath(item: index, section: 0),
                animated: true,
                scrollPosition: .centeredVertically
            )
        }
    }
    
    private func changeMonth(by value: Int) {
        guard let newDate = Calendar.current
            .date(byAdding: .month, value: value, to: currentMonth)
        else { return }
        
        currentMonth = newDate
        
        changePreviousButtonVisibleIfNeeded(newDate)
        
        updateCalendar()
    }
    
    private func updateCalendar() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM"
        monthLabel.text = dateFormatter.string(from: currentMonth)
        
        days = getDaysInMonth(for: currentMonth)
        
        calendarCollectionView.reloadData()
    }
    
    private func changePreviousButtonVisibleIfNeeded(_ newDate: Date) {
        if previousDateDisabled {
            // 새로운 달이 현재 달인지 확인
               let calendar = Calendar.current
               let currentDateComponents = calendar.dateComponents([.year, .month], from: Date())
               let newDateComponents = calendar.dateComponents([.year, .month], from: newDate)
               
            if currentDateComponents == newDateComponents {
                previousButton.isEnabled = false
            } else {
                previousButton.isEnabled = true
            }
        }
    }
    
    private func getDaysInMonth(for date: Date) -> [CalendarDay] {
        let calendar = Calendar.current
        
        // 현재 월의 첫 날과 마지막 날 구하기
        guard let firstDayOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: date)),
              let lastDayOfMonth = calendar.date(
                byAdding: DateComponents(month: 1, day: -1),
                to: firstDayOfMonth
              )
        else { return [] }
        
        // 첫 주의 시작일 (일요일) 구하기
        let firstWeekday = calendar.component(.weekday, from: firstDayOfMonth)
        let daysToSubtract = firstWeekday - 1
        let startDate = calendar.date(byAdding: .day, value: -daysToSubtract, to: firstDayOfMonth)!
        
        // 마지막 주의 끝일 (토요일) 구하기
        let lastWeekday = calendar.component(.weekday, from: lastDayOfMonth)
        let daysToAdd = 7 - lastWeekday
        let endDate = calendar.date(byAdding: .day, value: daysToAdd, to: lastDayOfMonth)!
        
        var days: [CalendarDay] = []
        var currentDate = startDate
        let monthRange = calendar.dateInterval(of: .month, for: self.currentMonth)!
        let today = Date()
        
        while currentDate <= endDate {
            let isCurrentMonth = monthRange.contains(currentDate)
            let weekday = calendar.component(.weekday, from: currentDate)
            let type: CalendarCellType = (weekday == 1) ? .sun : (weekday == 7) ? .sat : .weekday
            let isPreviousDate = currentDate >= calendar.startOfDay(for: today)
            
            let day = CalendarDay(
                type: type,
                date: currentDate,
                isCurrentMonth: isCurrentMonth,
                isPreviousDate: isPreviousDate
            )
            days.append(day)
            currentDate = calendar.date(byAdding: .day, value: 1, to: currentDate)!
        }
        
        return days
    }
}

// MARK: - CollectionView delegate
extension BaseCalendar: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    public func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return days.count
    }
    
    public func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "CalendarCell", 
            for: indexPath
        ) as? BaseCalendarCell else {
            return UICollectionViewCell()
        }
        
        let day = days[indexPath.item]
        
        cell.dayText = "\(Calendar.current.component(.day, from: day.date))"
        
        cell.styled(
            type: day.type,
            color: cellColor,
            shape: cellShape
        )
        
        cell.isEnabled = day.isCurrentMonth && day.isPreviousDate
        
        if previousDateDisabled {
            cell.isEnabled = day.isPreviousDate
        } else {
            cell.isEnabled = day.isCurrentMonth
        }

        if day == selectedDay {
            collectionView.selectItem(
                at: indexPath,
                animated: false,
                scrollPosition: .init()
            )
        }
        
        return cell
    }
    
    public func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let width = collectionView.frame.width / 7 - Self.Cellspacing
        return CGSize(width: width, height: width)
    }
    
    public func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        return Self.Cellspacing
    }
    
    public func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {
        return Self.Cellspacing
    }
    
    public func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        selectedDay = days[indexPath.item]
        
        if let selectedDate = selectedDay?.date {
            _onChangeSelectedDate.onNext(selectedDate)
        }
    }
}

// MARK: - Display model
extension BaseCalendar {
    struct CalendarDay: Equatable {
        let type: CalendarCellType
        let date: Date
        let isCurrentMonth: Bool
        let isPreviousDate: Bool
        
        static func == (lhs: CalendarDay, rhs: CalendarDay) -> Bool {
            return lhs.date == rhs.date
        }
    }
}
