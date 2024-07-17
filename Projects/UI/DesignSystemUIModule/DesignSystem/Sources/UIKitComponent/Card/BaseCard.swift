//
//  BaseCard.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 7/14/24.
//

import UIKit

import RxSwift
import Then
import SnapKit

/// Extension for set theme
public extension BaseCard {
    func styled(
        variant: BasicCardVariant = .outline,
        color: BasicCardColor = .gray,
        shape: BasicCardShape = .round,
        padding: BasicCardPadding = .large
    ) {
        let colorTheme = BasicCardColorTheme(
            variant: variant,
            color: color
        )
        let figureTheme = BasicCardFigureTheme(
            shape: shape, 
            padding: padding
        )
        
        self.colorTheme = colorTheme
        self.figureTheme = figureTheme
    }
}

public class BaseCard: UIView {
    public typealias ViewBuilder = () -> [UIView]
    
    // MARK: Theme
    private var colorTheme: BasicCardColorTheme? {
        didSet {
            updateCornerRadius()
            updateTheme()
            updateLayout()
        }
    }
    
    private var figureTheme: BasicCardFigureTheme? {
        didSet {
            updateCornerRadius()
            updateTheme()
            updateLayout()
        }
    }
    
    // MARK: UIConstant
    private let stackViewSpacing: CGFloat = 16
    
    // MARK: UI Component
    private lazy var backgroundView = UIView()
    
    private lazy var headerStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 8
        $0.distribution = .fill
        $0.alignment = .fill
    }
    
    private lazy var contentStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 8
        $0.distribution = .fill
        $0.alignment = .fill
    }
    
    private lazy var footerStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 8
        $0.distribution = .fill
        $0.alignment = .fill
    }
    
    // MARK: Build component
    private var headers: [UIView] = []
    
    private var contents: [UIView] = []
    
    private var footers: [UIView] = []
    
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
    
    public init(
        headerBuilder: ViewBuilder = { [] },
        contentsBuilder: ViewBuilder = { [] },
        footerBuilder: ViewBuilder = { [] }
    ) {
        super.init(frame: .zero)
        
        headers.append(contentsOf: headerBuilder())
        contents.append(contentsOf: contentsBuilder())
        footers.append(contentsOf: footerBuilder())
        
        setupHierarchy()
        setupBind()
        updateTheme()
        updateLayout()
        updateCornerRadius()
    }
    
    // MARK: Life cycle
    
    // MARK: Setup
    private func setupHierarchy() {
        self.addSubview(backgroundView)
        
        backgroundView.addSubview(headerStackView)
        backgroundView.addSubview(contentStackView)
        backgroundView.addSubview(footerStackView)
        
        headers.forEach {
            headerStackView.addArrangedSubview($0)
        }
        
        contents.forEach {
            contentStackView.addArrangedSubview($0)
        }
        
        footers.forEach {
            footerStackView.addArrangedSubview($0)
        }
    }
    
    private func setupBind() { }
    
    // MARK: Update
    private func updateCornerRadius() {
        guard let figureTheme = figureTheme else { return }
        
        let rounded = figureTheme.rounded()
        
        self.backgroundView.layer.cornerRadius = rounded.max
        self.backgroundView.layer.masksToBounds = true
    }
    
    private func updateTheme() {
        guard let colorTheme = colorTheme else { return }
        
        let backgroundColor = colorTheme.backgroundColor().uiColor
        let borderColor = colorTheme.borderColor().cgColor
        
        // background view
        backgroundView.backgroundColor = backgroundColor
        backgroundView.layer.borderColor = borderColor
        backgroundView.layer.borderWidth = 1
    }
    
    private func updateLayout() {
        guard let figureTheme = figureTheme else { return }
        
        let padding = figureTheme.padding()
        
        if self.superview != nil {
            self.snp.makeConstraints {
                $0.left.right.equalToSuperview()
            }
        }
        
        backgroundView.snp.remakeConstraints {
            $0.edges.equalToSuperview()
        }
        
        headerStackView.snp.remakeConstraints {
            $0.top.equalToSuperview().inset(padding.vertical ?? 0)
            $0.left.right.equalToSuperview().inset(padding.horizontal ?? 0)
            if headers.isEmpty {
                $0.height.equalTo(0)
            }
        }
        
        contentStackView.snp.remakeConstraints {
            let stackViewSpacing = calculateStackViewSpacing(
                topStackView: headerStackView,
                bottomStackView: contentStackView
            )
            
            $0.top.equalTo(headerStackView.snp.bottom).offset(stackViewSpacing)
            $0.left.right.equalToSuperview().inset(padding.horizontal ?? 0)
            
            if contents.isEmpty {
                $0.height.equalTo(0)
            }
        }
        
        footerStackView.snp.remakeConstraints {
            let stackViewSpacing = calculateStackViewSpacing(
                topStackView: contentStackView,
                bottomStackView: footerStackView
            )
            
            $0.top.equalTo(contentStackView.snp.bottom).offset(stackViewSpacing)
            $0.left.right.equalToSuperview().inset(padding.horizontal ?? 0)
            $0.bottom.equalToSuperview().inset(padding.vertical ?? 0)
            
            if footers.isEmpty {
                $0.height.equalTo(0)
            }
        }
    }
    
    private func calculateStackViewSpacing(
        topStackView: UIStackView,
        bottomStackView: UIStackView
    ) -> CGFloat {
        let previousSubviewCount = topStackView.arrangedSubviews.count
        let currentViewSubviewCount = bottomStackView.arrangedSubviews.count
        return (previousSubviewCount > 0 && currentViewSubviewCount > 0)
        ? self.stackViewSpacing
        : 0
    }
}
