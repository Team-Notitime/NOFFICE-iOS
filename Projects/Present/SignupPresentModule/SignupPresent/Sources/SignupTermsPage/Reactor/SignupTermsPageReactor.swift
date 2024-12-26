//
//  SignupTermsReactor.swift
//  SignupPresent
//
//  Created by DOYEON LEE on 7/18/24.
//

import Foundation

import RxSwift
import ReactorKit
import MainEntity

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
