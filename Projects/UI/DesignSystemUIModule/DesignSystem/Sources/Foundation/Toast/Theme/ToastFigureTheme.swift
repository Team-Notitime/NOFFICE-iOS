//
//  ToastFigureTheme.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/18/24.
//

import Foundation

protocol ToastFigureTheme {
    func padding() -> GapOffset
    func rounded() -> RoundedOffset
    func shape() -> AnyShape
    func imageName() -> ImageName?
    func imageSize() -> FrameOffset
    func messageTypo() -> Typo
}
