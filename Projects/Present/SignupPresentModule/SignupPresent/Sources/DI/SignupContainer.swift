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
        
        container.register(SignupReactor.self) { _ in
            SignupReactor()
        }
        .inObjectScope(.weak)
        
        container.register(SignupFunnelReactor.self) { resolver in
            SignupFunnelReactor(
                termsReactor: resolver.resolve(SignupTermsPageReactor.self)!,
                realNameReactor: resolver.resolve(SignupRealNamePageReactor.self)!
            )
        }
        .inObjectScope(.weak)
        
        container.register(SignupTermsPageReactor.self) { _ in
            SignupTermsPageReactor()
        }
        .inObjectScope(.weak)
        
        container.register(SignupRealNamePageReactor.self) { _ in
            SignupRealNamePageReactor()
        }
        .inObjectScope(.weak)
        
        container.register(SignupRealNamePageReactor.self) { _ in
            SignupRealNamePageReactor()
        }
        .inObjectScope(.weak)

        return container
    }()
}
