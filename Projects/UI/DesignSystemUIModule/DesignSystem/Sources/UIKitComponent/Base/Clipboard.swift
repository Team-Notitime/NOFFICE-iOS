//
//  ClipboardManager.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/13/24.
//

import UIKit

struct Clipboard {
    static func copyToClipboard(text: String) {
        UIPasteboard.general.string = text
    }
}
