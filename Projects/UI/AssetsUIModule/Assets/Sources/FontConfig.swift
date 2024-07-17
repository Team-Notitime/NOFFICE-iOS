//
//  FontConfig.swift
//  Assets
//
//  Created by DOYEON LEE on 7/17/24.
//

import UIKit
import CoreText

public struct FontConfig {
    public enum PretendardWeight: String, CaseIterable {
        case black = "Pretendard-Black"
        case bold = "Pretendard-Bold"
        case extraBold = "Pretendard-ExtraBold"
        case extraLight = "Pretendard-ExtraLight"
        case light = "Pretendard-Light"
        case medium = "Pretendard-Medium"
        case regular = "Pretendard-Regular"
        case semiBold = "Pretendard-SemiBold"
        case thin = "Pretendard-Thin"
    }
    
    public static func pretendard(size: CGFloat, weight: PretendardWeight = .regular) -> UIFont {
        return UIFont(name: weight.rawValue, size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    public static func setup() {
        PretendardWeight.allCases.forEach {
            guard let url = Bundle.module.url(forResource: $0.rawValue, withExtension: "otf"),
                  CTFontManagerRegisterFontsForURL(url as CFURL, .process, nil) else {
                print("Failed to register font: \($0.rawValue)")
                return
            }
        }
    }
}
