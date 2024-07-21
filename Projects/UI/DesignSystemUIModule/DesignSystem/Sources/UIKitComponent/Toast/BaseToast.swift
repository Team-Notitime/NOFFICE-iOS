//
//  BaseToast.swift
//  DesignSystemApp
//
//  Created by DOYEON LEE on 7/20/24.
//

import UIKit

import RxSwift
import Then
import SnapKit

public extension BaseToast {
    func show(
        in view: UIView,
        message: String,
        variant: BasicToastVariant = .info,
        shape: BasicToastShape = .round,
        alignment: BasicToastAlignment = .bottom,
        duration: TimeInterval = 3.0
    ) {
        // - Set message
        self.messageLabel.text = message
        
        // - Set theme
        self.colorTheme = BasicToastColorTheme(
            variant: variant
        )
        self.figureTheme = BasicToastFigureTheme(
            variant: variant,
            shape: shape
        )

        // - Set hierarchy
        view.addSubview(self)
        
        // Set initial frame and final frame for animation
        self.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().offset(100)
        }
        view.layoutIfNeeded()

        // - Animate
        UIView.animate(
            withDuration: 0.25,
            delay: 0,
            options: [.curveEaseInOut],
            animations: {
                self.snp.updateConstraints {
                    $0.bottom.equalToSuperview().offset(-100)
                }
                view.layoutIfNeeded()
            }
        ) { _ in
            DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                UIView.animate(withDuration: 0.35, animations: {
                    self.snp.updateConstraints {
                        $0.bottom.equalToSuperview().offset(100)
                    }
                    view.layoutIfNeeded()
                }) { _ in
                    self.removeFromSuperview()
                }
            }
        }
    }
}

public class BaseToast: UIView {
    // MARK: Theme
    private var colorTheme: BasicToastColorTheme? {
        didSet {
            updateTheme()
            updateLayout()
        }
    }
    
    private var figureTheme: BasicToastFigureTheme? {
        didSet {
            updateTheme()
            updateLayout()
        }
    }
    // MARK: UI Component
    private lazy var stackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 8
    }
    
    private lazy var iconImageView = UIImageView()
    
    private lazy var messageLabel = UILabel()
    
    // MARK: Build component
    
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
    
    public init() {
        super.init(frame: .zero)
        
        setupHierarchy()
        setupBind()
        updateTheme()
        updateLayout()
        updateCornerRadius()
    }
    
    // MARK: Life cycle
    public override func layoutSubviews() {
        super.layoutSubviews()
        updateCornerRadius()
    }
    
    // MARK: Setup
    private func setupHierarchy() {
        addSubview(stackView)
        
        stackView.addArrangedSubview(iconImageView)
        
        stackView.addArrangedSubview(messageLabel)
    }
    
    private func setupBind() { }
    
    // MARK: Update
    private func updateCornerRadius() {
        guard let figureTheme = figureTheme else { return }
        
        let rounded = figureTheme.rounded().max == .infinity
        ? bounds.height / 2 : figureTheme.rounded().max
        
        layer.cornerRadius = rounded
        clipsToBounds = true
    }
    
    private func updateTheme() {
        guard let colorTheme = colorTheme else { return }
        guard let figureTheme = figureTheme else { return }
        
        // - Theme value
        let backgroundColor = colorTheme.backgroundColor().uiColor
        let imageName = figureTheme.imageName()
        let foregroundColor = colorTheme.foregroundColor().uiColor
        let messageLabelTypo = figureTheme.messageTypo()
        
        // - Background
        self.backgroundColor = backgroundColor
        
        // - Icon image view
        switch imageName {
        case let .system(name):
            iconImageView.image = UIImage(systemName: name)
        case let .asset(name):
            iconImageView.image = UIImage(named: name)
        case .none:
            iconImageView.isHidden = true
        }
        iconImageView.tintColor = foregroundColor
        
        // - Message label
        messageLabel.setTypo(messageLabelTypo)
        messageLabel.textColor = foregroundColor
    }
    
    private func updateLayout() {
        guard let figureTheme = figureTheme else { return }
        
        // - Theme value
        let padding = figureTheme.padding()
        let imageSize = figureTheme.imageSize()
        
        // - Stack view
        stackView.snp.remakeConstraints {
            $0.top.bottom.equalToSuperview()
                .inset(padding.vertical ?? 0)
            $0.left.right.equalToSuperview()
                .inset(padding.horizontal ?? 0)
        }
        
        // - Icon image view
        iconImageView.snp.remakeConstraints {
            $0.width.height.equalTo(imageSize.same ?? 20)
        }
    }
}
