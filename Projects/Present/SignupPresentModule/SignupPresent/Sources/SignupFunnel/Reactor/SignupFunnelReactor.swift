//
//  SignupFunnelReactor.swift
//  SignupPresent
//
//  Created by DOYEON LEE on 7/18/24.
//

import Foundation

import Router

import ReactorKit

class SignupFunnelReactor: Reactor {
    
    // MARK: Action
    enum Action {
        case moveNextPage
        case movePreviousPage
    }
    
    enum Mutation {
        case setCurrentPage(SignupFunnelPage)
    }
    
    // MARK: State
    struct State {
        var currentPage: SignupFunnelPage = .terms
    }
    
    let initialState: State = State()
    
    // MARK: Child Reactor
    private let termsReactor: SignupTermsReactor
    
    private let realNameReactor: SignupRealNameReactor
    
    // MARK: DisposeBag
    private let disposeBag = DisposeBag()
    
    init(
        termsReactor: SignupTermsReactor,
        realNameReactor: SignupRealNameReactor
    ) {
        self.termsReactor = termsReactor
        self.realNameReactor = realNameReactor
        
        setupChildBind()
    }
    
    // MARK: Action operation
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .moveNextPage:
            let nextPage = nextPage(after: currentState.currentPage)
            return Observable.just(.setCurrentPage(nextPage))
        case .movePreviousPage:
            let previousPage = previousPage(before: currentState.currentPage)
            return Observable.just(.setCurrentPage(previousPage))
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case .setCurrentPage(let page):
            state.currentPage = page
        }
        return state
    }
    
    // MARK: Child bind
    private func setupChildBind() {
        termsReactor.action
            .subscribe(onNext: { [weak self] action in
                switch action {
                case .tapNextPageButton:
                    self?.action.onNext(.moveNextPage)
                case .tapBackButton:
                    self?.action.onNext(.movePreviousPage)
                default: return
                }
            })
            .disposed(by: disposeBag)
        
        realNameReactor.action
            .subscribe(onNext: { [weak self] action in
                switch action {
                case .tapCompleteButton:
                    Router.shared.dismiss()
                default: return
                }
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: Private method
    private func nextPage(after page: SignupFunnelPage) -> SignupFunnelPage {
        let allPages = SignupFunnelPage.allCases
        
        if let currentIndex = allPages.firstIndex(of: page), 
            currentIndex < allPages.count - 1 {
            return allPages[currentIndex + 1]
        }
        
        return page
    }
    
    private func previousPage(before page: SignupFunnelPage) -> SignupFunnelPage {
        let allPages = SignupFunnelPage.allCases
        
        if let currentIndex = allPages.firstIndex(of: page), 
            currentIndex > 0 {
            return allPages[currentIndex - 1]
        }
        
        return page
    }
}
