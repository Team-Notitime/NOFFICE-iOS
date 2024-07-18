//
//  SignupTermsReactor.swift
//  SignupPresent
//
//  Created by DOYEON LEE on 7/18/24.
//

import Foundation

import RxSwift
import ReactorKit

class SignupTermsPageReactor: Reactor {
    // MARK: Action
    enum Action {
        case tapNextPageButton
        case tapBackButton
        case changeSelectedTermOptions([TermOptionType])
    }
    
    enum Mutation { 
        case setSelectedTermOptions([TermOptionType])
        case changeNextButtonActive([TermOptionType])
    }
    
    // MARK: State
    struct State { 
        var selectedTermOptions: [TermOptionType] = []
        var nextButtonActive: Bool = false
    }
    
    let initialState: State = State()
    
    // MARK: Initializer
    init() {  }
    
    // MARK: Action operation
    func mutate(action: Action) -> Observable<Mutation> {
        switch action { 
        case .tapNextPageButton:
            // pass to parent
            return .empty()
            
        case .tapBackButton:
            // pass to parent
            return .empty()
            
        case let .changeSelectedTermOptions(options):
            return .merge(
                .just(Mutation.setSelectedTermOptions(options)),
                .just(Mutation.changeNextButtonActive(options))
            )
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation { 
        case let .setSelectedTermOptions(options):
            state.selectedTermOptions = options
            
        case let .changeNextButtonActive(options):
            let nextButtonActive = checkSelectedAllRequiredTermOptions(
                options
            )
            state.nextButtonActive = nextButtonActive
        }
        return state
    }
    
    // MARK: Private method
    private func checkSelectedAllRequiredTermOptions(
        _ selectedOptions: [TermOptionType]
    ) -> Bool {
        let requiredOptions = TermOptionType
            .allCases.filter { $0.termOption.required }
        return requiredOptions
            .allSatisfy { selectedOptions.contains($0) }
    }
}

// MARK: - Display model
extension SignupTermsPageReactor { 
    enum TermOptionType: Int, CaseIterable {
        case age = 0
        case service = 1
        case personal = 2
        case marketing = 3
        
        var termOption: TermOption {
            switch self {
            case .age:
                return .init(type: self, order: rawValue, text: "(필수) 만 14세 이상입니다.", required: true)
            case .service:
                return .init(type: self, order: rawValue, text: "(필수) 서비스 이용약관 동의", required: true)
            case .personal:
                return .init(type: self, order: rawValue, text: "(필수) 개인정보 처리방침 동의", required: true)
            case .marketing:
                return .init(type: self, order: rawValue, text: "(선택) 마케팅 수신 동의", required: false)
            }
        }
    }
    
    // 임시. Domain entity로 변경하기.
    struct TermOption: Identifiable, Equatable {
        let type: TermOptionType?
        let order: Int
        let text: String
        let description: String?
        let url: URL?
        let required: Bool
        
        init(
            type: TermOptionType? = nil,
            order: Int = -1,
            text: String,
            description: String? = nil,
            url: URL? = nil,
            required: Bool = false
        ) {
            self.type = type
            self.order = order
            self.text = text
            self.description = description
            self.url = url
            self.required = required
        }
        
        public var id: String {
            return text
        }
    }
}
