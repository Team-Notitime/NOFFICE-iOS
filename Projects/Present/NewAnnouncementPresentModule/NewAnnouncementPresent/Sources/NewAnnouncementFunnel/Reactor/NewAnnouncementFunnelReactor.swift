//
//  NewAnnouncementFunnelReactor.swift
//  NewAnnouncementPresent
//
//  Created by DOYEON LEE on 7/22/24.
//

import Foundation

import Router

import ReactorKit

class NewAnnouncementFunnelReactor: Reactor {
    
    // MARK: Action
    enum Action {
        case moveNextPage
        case movePreviousPage
    }
    
    enum Mutation {
        case setCurrentPage(NewAnnouncementFunnelPage)
    }
    
    // MARK: State
    struct State {
        var currentPage: NewAnnouncementFunnelPage = .selectOrganization
    }
    
    let initialState: State = State()
    
    // MARK: Child Reactor
    private let selectOrganizationReactor: SelectOrganizationPageReactor
    
    private let editContentsReactor: EditContentsPageReactor
    
    // MARK: DisposeBag
    private let disposeBag = DisposeBag()
    
    // MARK: Initializer
    init(
        selectOrganizationReactor: SelectOrganizationPageReactor,
        editContentsReactor: EditContentsPageReactor
    ) {
        self.selectOrganizationReactor = selectOrganizationReactor
        self.editContentsReactor = editContentsReactor
        
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
        selectOrganizationReactor.action
            .subscribe(onNext: { [weak self] action in
                switch action {
                case .tapNextPageButton:
                    self?.action.onNext(.moveNextPage)
                default: return
                }
            })
            .disposed(by: disposeBag)
        
        editContentsReactor.action
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
    private func nextPage(after page: NewAnnouncementFunnelPage) -> NewAnnouncementFunnelPage {
        let allPages = NewAnnouncementFunnelPage.allCases
        
        if let currentIndex = allPages.firstIndex(of: page),
            currentIndex < allPages.count - 1 {
            return allPages[currentIndex + 1]
        }
        
        return page
    }
    
    private func previousPage(before page: NewAnnouncementFunnelPage) -> NewAnnouncementFunnelPage {
        let allPages = NewAnnouncementFunnelPage.allCases
        
        if let currentIndex = allPages.firstIndex(of: page),
            currentIndex > 0 {
            return allPages[currentIndex - 1]
        }
        
        return page
    }
}
