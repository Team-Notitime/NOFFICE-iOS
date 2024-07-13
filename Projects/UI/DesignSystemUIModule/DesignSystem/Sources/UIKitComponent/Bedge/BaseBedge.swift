//
//  BaseBedge.swift
//  DesignSystemApp
//
//  Created by DOYEON LEE on 7/14/24.
//

import UIKit

import RxSwift
import Then
import SnapKit

/// Extension for set theme
public extension BaseBedge {
    func styled(
        color: BasicBedgeColor = .green,
        variant: BasicBedgeVariant = .on
    ) {
        let colorTheme = BasicBedgeColorTheme(color: color, variant: variant)
        let figureTheme = BasicBedgeFigureTheme()
        
        self.colorTheme = colorTheme
        self.figureTheme = figureTheme
    }
}

/// Extension for set content
public extension BaseBedge {
}

public class BaseBedge: UIView {
    // MARK: Theme
    private var colorTheme: BasicBedgeColorTheme? {
        didSet {
            updateCornerRadius()
            updateTheme()
            updateLayout()
        }
    }
    
    private var figureTheme: BasicBedgeFigureTheme? {
        didSet {
            updateCornerRadius()
            updateTheme()
            updateLayout()
        }
    }
    
    // MARK: UIConstant
    
    // MARK: UI Component
    private lazy var itemStack = UIStackView()
    
    // MARK: DisposeBag
    private let disposeBag = DisposeBag()
    
    // MARK: Initializer
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupHierachy()
        updateCornerRadius()
        setupBind()
        updateTheme()
        updateLayout()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupHierachy()
        setupBind()
        updateCornerRadius()
        updateTheme()
        updateLayout()
    }
    
    public convenience init() {
        self.init(frame: .zero)
    }
    
    // MARK: Life cycle
    
    // MARK: Setup
    private func setupHierachy() {
    }
    
    private func setupBind() { }
    
    // MARK: Update
    private func updateCornerRadius() {
        guard let figureTheme = figureTheme else { return }
    }
    
    private func updateTheme() {
        guard let colorTheme = colorTheme else { return }
        
    }
    
    private func updateLayout() {
    }
}
