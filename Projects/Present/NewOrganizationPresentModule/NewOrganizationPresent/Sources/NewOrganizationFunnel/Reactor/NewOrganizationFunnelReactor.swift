//
//  NewOrganizationFunnelReactor.swift
//  OrganizationPresent
//
//  Created by DOYEON LEE on 7/19/24.
//

import Foundation

import Router
import OrganizationUsecase
import OrganizationEntity

import ReactorKit
import ProgressHUD

class NewOrganizationFunnelReactor: Reactor {
    // MARK: Action
    enum Action { 
        case moveNextPage
        case movePreviousPage
    }
    
    enum Mutation { 
        case setCurrentPage(NewOrganizationFunnelPage)
    }
    
    // MARK: State
    struct State { 
        var pages: [NewOrganizationFunnelPage] = NewOrganizationFunnelPage.allCases
        var currentPage: NewOrganizationFunnelPage = .name
    }
    
    let initialState: State = State()
    
    // MARK: ChildReactor
    private let nameReactor: NewOrganizationNamePageReactor
    
    private let categoryReactor: NewOrganizationCategoryPageReactor
    
    private let imageReactor: NewOrganizationImagePageReactor
    
    private let endDateReactor: NewOrganizationDatePageReactor
    
    private let promotionReactor: NewOrganizationPromotionPageReactor
    
    private let completeReactor: NewOrganizationCompletePageReactor
    
    // MARK: Dependency
    private let createOrganizationUsecase = CreateOrganizationUsecase()
    
    // MARK: DisposeBag
    private let disposeBag = DisposeBag()
    
    // MARK: Initializer
    init(
        nameReactor: NewOrganizationNamePageReactor,
        categoryReactor: NewOrganizationCategoryPageReactor,
        imageReactor: NewOrganizationImagePageReactor,
        endDateReactor: NewOrganizationDatePageReactor,
        promotionReactor: NewOrganizationPromotionPageReactor,
        completeReactor: NewOrganizationCompletePageReactor
    ) {
        self.nameReactor = nameReactor
        self.categoryReactor = categoryReactor
        self.imageReactor = imageReactor
        self.endDateReactor = endDateReactor
        self.promotionReactor = promotionReactor
        self.completeReactor = completeReactor
        
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
        nameReactor.action
            .subscribe(onNext: { [weak self] action in
                switch action {
                case .tapNextPageButton:
                    self?.action.onNext(.moveNextPage)
                default: return
                }
            })
            .disposed(by: disposeBag)
        
        categoryReactor.action
            .subscribe(onNext: { [weak self] action in
                switch action {
                case .tapNextPageButton:
                    self?.action.onNext(.moveNextPage)
                default: return
                }
            })
            .disposed(by: disposeBag)
        
        imageReactor.action
            .subscribe(onNext: { [weak self] action in
                switch action {
                case .tapNextPageButton:
                    self?.action.onNext(.moveNextPage)
                default: return
                }
            })
            .disposed(by: disposeBag)
        
        endDateReactor.action
            .subscribe(onNext: { [weak self] action in
                switch action {
                case .tapNextPageButton:
                    self?.action.onNext(.moveNextPage)
                default: return
                }
            })
            .disposed(by: disposeBag)
        
        promotionReactor.action
            .flatMapLatest { [weak self] action -> Observable<Void> in
                guard let self = self else { return .empty() }

                switch action {
                case .tapCompleteButton:
                    let newOrganization = NewOrganizationEntity(
                        name: self.nameReactor.currentState.name,
                        categories: self.categoryReactor.currentState.selectedCateogries.map { $0.id },
                        imageURL: self.imageReactor.currentState.uploadedUrl,
                        endDate: self.endDateReactor.currentState.selectedDate,
                        promotionCode: self.promotionReactor.currentState.promotionCode
                    )
                    
                    ProgressHUD.animate(
                        "그룹을 생성중입니다",
                        .horizontalDotScaling,
                        interaction: false
                    )
                    
                    return self.createOrganizationUsecase
                        .execute(.init(newOrganization: newOrganization))
                        .map { _ in
                            ProgressHUD.dismiss()
                            return Void()
                        }
                    
                default:
                    return .empty()
                }
            }
            .observe(on: MainScheduler.asyncInstance)
            .subscribe(
                with: self,
                onNext: { owner, _ in
                    owner.action.onNext(.moveNextPage)
                }, onError: { _, error in
                    // 에러 핸들링 추가 필요
                    print("Error: \(error)")
                }
            )
            .disposed(by: disposeBag)
        
        completeReactor.action
            .subscribe(onNext: { action in
                switch action {
                case .tapGoHomeButton:
                    DispatchQueue.main.async {
                        Router.shared.back()
                    }
                default: return
                }
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: Transform
    
    // MARK: Private method
    private func nextPage(
        after page: NewOrganizationFunnelPage
    ) -> NewOrganizationFunnelPage {
        let allPages = NewOrganizationFunnelPage.allCases
        
        if let currentIndex = allPages.firstIndex(of: page),
            currentIndex < allPages.count - 1 {
            return allPages[currentIndex + 1]
        }
        
        return page
    }
    
    private func previousPage(
        before page: NewOrganizationFunnelPage
    ) -> NewOrganizationFunnelPage {
        let allPages = NewOrganizationFunnelPage.allCases
        
        if let currentIndex = allPages.firstIndex(of: page),
            currentIndex > 0 {
            return allPages[currentIndex - 1]
        }
        
        return page
    }
}
