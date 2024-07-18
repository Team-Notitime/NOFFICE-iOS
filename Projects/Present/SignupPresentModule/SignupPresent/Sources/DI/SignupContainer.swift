//
//  Container.swift
//  SignupPresent
//
//  Created by DOYEON LEE on 7/18/24.
//

import Swinject

extension Container {
    static let shared: Container = {
        let container = Container()
        
        container.register(SignupFunnelReactor.self) { resolver in
            SignupFunnelReactor(
                termsReactor: resolver.resolve(SignupTermsReactor.self)!,
                realNameReactor: resolver.resolve(SignupRealNameReactor.self)!
            )
        }
        .inObjectScope(.weak)
        
        container.register(SignupTermsReactor.self) { _ in
            SignupTermsReactor()
        }
        .inObjectScope(.weak)
        
        container.register(SignupRealNameReactor.self) { _ in
            SignupRealNameReactor()
        }
        .inObjectScope(.weak)

        return container
    }()
}
