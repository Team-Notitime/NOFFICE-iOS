//
//  Font+Extension.swift
//  IP-iOS
//
//  Created by DOYEON LEE on 6/1/24.
//

import UIKit
import SwiftUI

/// System default is 0.0
let lineSpacingMultiplier: CGFloat = 0.2

public enum FontWeight: String {
    case thin, extraLight, light, regular, medium
    case semibold, bold, extraBold, black
}

extension FontWeight {
    var swiftuiWeight: Font.Weight? {
        switch self {
        case .thin:
            return .thin
        case .extraLight:
            return .thin
        case .light:
            return .light
        case .regular:
            return .regular
        case .medium:
            return .medium
        case .semibold:
            return .semibold
        case .bold:
            return .bold
        case .extraBold:
            return .black
        case .black:
            return .black
        }
    }
    
    var uikitWeight: UIFont.Weight {
        switch self {
        case .thin:
            return .thin
        case .extraLight:
            return .thin
        case .light:
            return .light
        case .regular:
            return .regular
        case .medium:
            return .medium
        case .semibold:
            return .semibold
        case .bold:
            return .bold
        case .extraBold:
            return .black
        case .black:
            return .black
        }
    }
}

public enum Typo {
    /// Font size: 32, weight: bold
    case heading1
    /// Font size: 28, weight: bold
    case heading2
    /// Font size: 22, weight: semibold
    case heading3
    /// Font size: 20, weight: semibold
    case heading4
    /// Font size: 18, weight: regular
    case body0    
    /// Font size: 18, weight: medium
    case body0m
    /// Font size: 18, weight: semibold
    case body0b
    /// Font size: 16, weight: regular
    case body1    
    /// Font size: 16, weight: medium
    case body1m
    /// Font size: 16, weight: semibold
    case body1b
    /// Font size: 14, weight: regular
    case body2
    /// Font size: 14, weight: semibold
    case body2b
    /// Font size: 12, weight: regular
    case body3
    /// Font size: 12, weight: semibold
    case body3b
    /// Font size: 10, weight: regular
    case detail
}

public extension UILabel {
    /// Set the default font of the text.
    ///
    /// ```swift
    /// let label = UILabel()
    /// label.setDefaultFont(size: 18, weight: .bold)
    /// ```
    ///
    func setDefaultFont(
        size: CGFloat = 16,
        weight: FontWeight = .regular
    ) {
        switch weight {
        case .thin:
            self.font = UIFont(name: "Pretendard-Thin", size: size)
        case .extraLight:
            self.font = UIFont(name: "Pretendard-ExtraLight", size: size)
        case .light:
            self.font = UIFont(name: "Pretendard-Light", size: size)
        case .regular:
            self.font = UIFont(name: "Pretendard-Regular", size: size)
        case .medium:
            self.font = UIFont(name: "Pretendard-Medium", size: size)
        case .semibold:
            self.font = UIFont(name: "Pretendard-SemiBold", size: size)
        case .bold:
            self.font = UIFont(name: "Pretendard-Bold", size: size)
        case .extraBold:
            self.font = UIFont(name: "Pretendard-ExtraBold", size: size)
        case .black:
            self.font = UIFont(name: "Pretendard-Black", size: size)
        }
        
        self.setLineHeight(multiplier: lineSpacingMultiplier)
    }
    
    func setLineHeight(multiplier: CGFloat) {
        guard let labelText = self.text else { return }
        
        let fontSize = self.font.pointSize
        let lineHeight = fontSize * multiplier
        let lineSpacing = lineHeight - fontSize
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        
        let attributedString = NSMutableAttributedString(string: labelText)
        attributedString.addAttribute(
            .paragraphStyle,
            value: paragraphStyle,
            range: NSRange(location: 0, length: attributedString.length)
        )
        self.attributedText = attributedString
    }

    // swiftlint:disable:next orphaned_doc_comment
    /// Set the typography of the text.
    ///
    /// ```swift
    /// let label = UILabel()
    /// label.setTypo(.heading1)
    /// ```
    ///
    // swiftlint:disable:next cyclomatic_complexity
    func setTypo(_ typo: Typo) {
        switch typo {
        case .heading1:
            self.setDefaultFont(size: 32, weight: .bold)
        case .heading2:
            self.setDefaultFont(size: 28, weight: .bold)
        case .heading3:
            self.setDefaultFont(size: 22, weight: .semibold)
        case .heading4:
            self.setDefaultFont(size: 20, weight: .semibold)
        case .body0:
            self.setDefaultFont(size: 18, weight: .regular)        
        case .body0m:
            self.setDefaultFont(size: 18, weight: .medium)
        case .body0b:
            self.setDefaultFont(size: 18, weight: .semibold)
        case .body1:
            self.setDefaultFont(size: 16, weight: .regular)        
        case .body1m:
            self.setDefaultFont(size: 16, weight: .medium)
        case .body1b:
            self.setDefaultFont(size: 16, weight: .semibold)
        case .body2:
            self.setDefaultFont(size: 14, weight: .regular)
        case .body2b:
            self.setDefaultFont(size: 14, weight: .semibold)
        case .body3:
            self.setDefaultFont(size: 12, weight: .regular)
        case .body3b:
            self.setDefaultFont(size: 12, weight: .semibold)
        case .detail:
            self.setDefaultFont(size: 10, weight: .regular)
        }
    }
}

public extension UITextField {
    /// Set the default font of the text.
    ///
    /// ```swift
    /// let textField = UITextField()
    /// textField.setDefaultFont(size: 18, weight: .bold)
    /// ```
    ///
    func setDefaultFont(
        size: CGFloat = 16,
        weight: FontWeight = .regular
    ) {
        switch weight {
        case .thin:
            self.font = UIFont(name: "Pretendard-Thin", size: size)
        case .extraLight:
            self.font = UIFont(name: "Pretendard-ExtraLight", size: size)
        case .light:
            self.font = UIFont(name: "Pretendard-Light", size: size)
        case .regular:
            self.font = UIFont(name: "Pretendard-Regular", size: size)
        case .medium:
            self.font = UIFont(name: "Pretendard-Medium", size: size)
        case .semibold:
            self.font = UIFont(name: "Pretendard-SemiBold", size: size)
        case .bold:
            self.font = UIFont(name: "Pretendard-Bold", size: size)
        case .extraBold:
            self.font = UIFont(name: "Pretendard-ExtraBold", size: size)
        case .black:
            self.font = UIFont(name: "Pretendard-Black", size: size)
        }
        
        self.setLineHeight(multiplier: lineSpacingMultiplier)
    }
    
    func setLineHeight(multiplier: CGFloat) {
        guard let text = self.text else { return }
        
        let fontSize = self.font?.pointSize ?? 16
        let lineHeight = fontSize * multiplier
        let lineSpacing = lineHeight - fontSize
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(
            .paragraphStyle,
            value: paragraphStyle,
            range: NSRange(location: 0, length: attributedString.length)
        )
        self.attributedText = attributedString
    }

    /// Set the typography of the text.
    ///
    /// ```swift
    /// let textField = UITextField()
    /// textField.setTypo(.heading1)
    /// ```
    ///
    func setTypo(_ typo: Typo) {
        switch typo {
        case .heading1:
            self.setDefaultFont(size: 32, weight: .bold)
        case .heading2:
            self.setDefaultFont(size: 28, weight: .bold)
        case .heading3:
            self.setDefaultFont(size: 22, weight: .semibold)
        case .heading4:
            self.setDefaultFont(size: 20, weight: .semibold)
        case .body0:
            self.setDefaultFont(size: 18, weight: .regular)        
        case .body0m:
            self.setDefaultFont(size: 18, weight: .medium)
        case .body0b:
            self.setDefaultFont(size: 18, weight: .semibold)
        case .body1:
            self.setDefaultFont(size: 16, weight: .regular)        
        case .body1m:
            self.setDefaultFont(size: 16, weight: .medium)
        case .body1b:
            self.setDefaultFont(size: 16, weight: .semibold)
        case .body2:
            self.setDefaultFont(size: 14, weight: .regular)
        case .body2b:
            self.setDefaultFont(size: 14, weight: .semibold)
        case .body3:
            self.setDefaultFont(size: 12, weight: .regular)
        case .body3b:
            self.setDefaultFont(size: 12, weight: .semibold)
        case .detail:
            self.setDefaultFont(size: 10, weight: .regular)
        }
    }
}

public extension UITextView {
    /// Set the default font of the text.
    ///
    /// ```swift
    /// let textView = UITextView()
    /// textView.setDefaultFont(size: 18, weight: .bold)
    /// ```
    ///
    func setDefaultFont(
        size: CGFloat = 16,
        weight: FontWeight = .regular
    ) {
        switch weight {
        case .thin:
            self.font = UIFont(name: "Pretendard-Thin", size: size)
        case .extraLight:
            self.font = UIFont(name: "Pretendard-ExtraLight", size: size)
        case .light:
            self.font = UIFont(name: "Pretendard-Light", size: size)
        case .regular:
            self.font = UIFont(name: "Pretendard-Regular", size: size)
        case .medium:
            self.font = UIFont(name: "Pretendard-Medium", size: size)
        case .semibold:
            self.font = UIFont(name: "Pretendard-SemiBold", size: size)
        case .bold:
            self.font = UIFont(name: "Pretendard-Bold", size: size)
        case .extraBold:
            self.font = UIFont(name: "Pretendard-ExtraBold", size: size)
        case .black:
            self.font = UIFont(name: "Pretendard-Black", size: size)
        }
    }

    /// Set the typography of the text.
    ///
    /// ```swift
    /// let textView = UITextView()
    /// textView.setTypo(.heading1)
    /// ```
    ///
    func setTypo(_ typo: Typo) {
        switch typo {
        case .heading1:
            self.setDefaultFont(size: 32, weight: .bold)
        case .heading2:
            self.setDefaultFont(size: 28, weight: .bold)
        case .heading3:
            self.setDefaultFont(size: 22, weight: .semibold)
        case .heading4:
            self.setDefaultFont(size: 20, weight: .semibold)
        case .body0:
            self.setDefaultFont(size: 18, weight: .regular)
        case .body0m:
            self.setDefaultFont(size: 18, weight: .medium)
        case .body0b:
            self.setDefaultFont(size: 18, weight: .semibold)
        case .body1:
            self.setDefaultFont(size: 16, weight: .regular)
        case .body1m:
            self.setDefaultFont(size: 16, weight: .medium)
        case .body1b:
            self.setDefaultFont(size: 16, weight: .semibold)
        case .body2:
            self.setDefaultFont(size: 14, weight: .regular)
        case .body2b:
            self.setDefaultFont(size: 14, weight: .semibold)
        case .body3:
            self.setDefaultFont(size: 12, weight: .regular)
        case .body3b:
            self.setDefaultFont(size: 12, weight: .semibold)
        case .detail:
            self.setDefaultFont(size: 10, weight: .regular)
        }
    }
}
