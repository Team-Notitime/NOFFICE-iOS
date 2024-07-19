//
//  InjectIIIConfig.swift
//  OrganizationExample
//
//  Created by DOYEON LEE on 7/19/24.
//

import UIKit

struct InjectIIIConfig {
    static func setup() {
#if DEBUG
        Bundle(path: "/Applications/InjectionIII.app/Contents/Resources/iOSInjection.bundle")?.load()
#endif
    }
}

extension UIViewController {
    @objc func injected() {
        viewDidLoad()
    }
}
