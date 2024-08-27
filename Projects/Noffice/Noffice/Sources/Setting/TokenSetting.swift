//
//  TokenSetting.swift
//  Noffice
//
//  Created by DOYEON LEE on 8/28/24.
//

import KeychainUtility
import Router

@MainActor
struct TokenSetting {
    static func setup() {
        let tokenKeychainManager = KeychainManager<Token>()
        if let token = tokenKeychainManager.get() {
            print(token)
        } else {
            print("has no token")
            Router.shared.presentFullScreen(.signup, animated: false)
        }
    }
}
