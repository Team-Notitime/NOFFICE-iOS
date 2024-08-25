//
//  ProgressHudConfig.swift
//  Noffice
//
//  Created by DOYEON LEE on 8/25/24.
//

import Assets

import ProgressHUD

enum ProgressHudConfig {
    static func setup() {
        ProgressHUD.colorHUD = .white.withAlphaComponent(0)
        ProgressHUD.colorAnimation = .green500
    }
}
