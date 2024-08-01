//
//  BaseCalendar.swift
//  DesignSystemApp
//
//  Created by DOYEON LEE on 7/19/24.
//

import UIKit

import RxSwift
import Then
import SnapKit

/// Extension for set theme
 extension BaseCalendarCell {
    func styled(
        type: CalendarCellType,
        color: BasicCalendarCellColor,
        shape: BasicCalendarCellShape
    ) {
        let colorTheme = BasicCalendarCellColorTheme(
            color: color,
            type: type
        )
        let figureTheme = BasicCalendarCellFigureTheme(
            shape: shape
        )

        self.colorTheme = colorTheme
        self.figureTheme = figureTheme
    }
 }

public class BaseCalendarCell: UICollectionViewCell {
    public typealias ViewBuilder = () -> [UIView]
    // MARK: Event
    
    // MARK: State
    public var dayText: String = "" {
        didSet {
            dayLabel.text = dayText
        }
    }
    
    public override var isSelected: Bool {
        get {
            return super.isSelected
        }
        set {
            if isEnabled {
                super.isSelected = newValue
                updateTheme()
            }
        }
    }
    
    public var isEnabled: Bool = true {
        didSet {
            if isEnabled {
                isUserInteractionEnabled = true
            } else {
                isUserInteractionEnabled = false
            }
            updateTheme()
        }
    }
    
    // MARK: Theme
    private var colorTheme: BasicCalendarCellColorTheme? {
        didSet {
            updateCornerRadius()
            updateTheme()
            updateLayout()
        }
    }
    
    private var figureTheme: BasicCalendarCellFigureTheme? {
        didSet {
            updateCornerRadius()
            updateTheme()
            updateLayout()
        }
    }
    
    // MARK: UI Component
    private var dayLabel = UILabel().then {
        $0.setTypo(.body2b)
        $0.textAlignment = .center
    }
    
    // MARK: DisposeBag
    private let disposeBag = DisposeBag()
    
    // MARK: Initializer
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupHierarchy()
        setupBind()
        updateTheme()
        updateLayout()
        updateCornerRadius()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupHierarchy()
        setupBind()
        updateTheme()
        updateLayout()
        updateCornerRadius()
    }
    
    public init(day: String) {
        dayLabel.text = day
        
        super.init(frame: .zero)
        
        setupHierarchy()
        setupBind()
        updateTheme()
        updateLayout()
        updateCornerRadius()
    }
    
    // MARK: Life cycle
    public override func prepareForReuse() {
        super.prepareForReuse()
        
        dayLabel.text = ""
        isEnabled = true
        isSelected = false
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        updateCornerRadius()
    }
    
    // MARK: Setup
    private func setupHierarchy() {
        addSubview(dayLabel)
    }
    
    private func setupBind() { }
    
    // MARK: Update
    private func updateCornerRadius() {
        guard let figureTheme = figureTheme
        else { return }
        
        let rounded = figureTheme.rounded().max == .infinity
        ? bounds.height / 2 : figureTheme.rounded().max
        
        layer.cornerRadius = rounded
        clipsToBounds = true
    }
    
    private func updateTheme() {
        guard let colorTheme = colorTheme
        else { return }
        
        // - Color
        let state = getState()
        let backgroundColor = colorTheme.backgroundColor(state: state).uiColor
        let foregroundColor = colorTheme.foregroundColor(state: state).uiColor
        let borderColor = colorTheme.borderColor(state: state).cgColor
        
        // - Background view
        self.backgroundColor = backgroundColor
        self.layer.borderColor = borderColor
        self.layer.borderWidth = 1
        
        // - Day label
        self.dayLabel.textColor = foregroundColor
    }
    
    private func updateLayout() {
        dayLabel.snp.remakeConstraints {
            $0.left.right.equalToSuperview()
            $0.top.equalToSuperview().inset(4)
        }
    }
    
    // MARK: Inner token
    func getState() -> CalendarCellState {
        if isSelected {
            return .selected
        } else if !isEnabled {
            return .disabled
        } else {
            return .normal
        }
    }
}
