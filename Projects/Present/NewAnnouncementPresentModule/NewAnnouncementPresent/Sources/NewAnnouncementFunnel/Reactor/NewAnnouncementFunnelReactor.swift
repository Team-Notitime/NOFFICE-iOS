//
//  NewAnnouncementFunnelReactor.swift
//  NewAnnouncementPresent
//
//  Created by DOYEON LEE on 7/22/24.
//

import Foundation

import AnnouncementEntity
import AnnouncementUsecase
import OrganizationUsecase
import Router

import ReactorKit
import ProgressHUD

// FIXME: 여기는 증맬루 심각합니다...
class NewAnnouncementFunnelReactor: Reactor {
    // MARK: Action
    enum Action {
        case viewDidLoad
        case moveNextPage
        case movePreviousPage
        case toggleisOpenHasLeaderRoleOrganizationDialog
    }
    
    enum Mutation {
        case setCurrentPage(NewAnnouncementFunnelPage)
        case toggleisOpenHasLeaderRoleOrganizationDialog
    }
    
    // MARK: State
    struct State {
        var currentPage: NewAnnouncementFunnelPage = .selectOrganization
        
        // - View TODO: ㅠㅠ 어떡하지 변수명 머선일
        var isOpenHasLeaderRoleOrganizationDialog: Bool = false
    }
    
    let initialState: State = State()
    
    // MARK: Dependency
    private let createAnnouncementUsecase = CreateAnnouncementUsecase()
    
    // FIXME: 호출 최소화를 위한 고민 필요 (자식 리액토에서도 한번 호출함)
    private let getJoinedOrganizationsUsecase = GetJoinedOrganizationsUsecase()
    
    // MARK: Child Reactor
    private let selectOrganizationReactor: SelectOrganizationPageReactor
    
    private let editContentsReactor: EditContentsPageReactor
    
    // 실질적으로는 editContents의 자식 reactor 인데...더 좋은 방향이 없을지 고민 필요
    private let editDateTimeReactor: EditDateTimeReactor
    
    private let editPlaceReactor: EditPlaceReactor
    
    private let editTodoReactor: EditTodoReactor
    
    private let editNotificationReactor: EditNotificationReactor
    
    // MARK: DisposeBag
    private let disposeBag = DisposeBag()
    
    // MARK: Initializer
    init(
        selectOrganizationReactor: SelectOrganizationPageReactor,
        editContentsReactor: EditContentsPageReactor,
        editDateTimeReactor: EditDateTimeReactor,
        editPlaceReactor: EditPlaceReactor,
        editTodoReactor: EditTodoReactor,
        editNotificationReactor: EditNotificationReactor
    ) {
        self.selectOrganizationReactor = selectOrganizationReactor
        self.editContentsReactor = editContentsReactor
        self.editDateTimeReactor = editDateTimeReactor
        self.editPlaceReactor = editPlaceReactor
        self.editTodoReactor = editTodoReactor
        self.editNotificationReactor = editNotificationReactor
        
        setupChildBind()
    }
    
    // MARK: Action operation
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .viewDidLoad:
            ProgressHUD.animate(nil, .horizontalDotScaling, interaction: false)
            
            // TODO: 리더롤인지 확인하는 절차 필요
            let leaderRoleObservable = getJoinedOrganizationsUsecase
                .execute(.init())
                .compactMap {
                    ProgressHUD.dismiss()
                    return $0.organizations.isEmpty ? () : nil
                }
                .map {
                    return Mutation.toggleisOpenHasLeaderRoleOrganizationDialog
                }
            
            return leaderRoleObservable
            
        case .moveNextPage:
            let nextPage = nextPage(after: currentState.currentPage)
            return Observable.just(.setCurrentPage(nextPage))

        case .movePreviousPage:
            let previousPage = previousPage(before: currentState.currentPage)
            return Observable.just(.setCurrentPage(previousPage))
            
        case .toggleisOpenHasLeaderRoleOrganizationDialog:
            return .just(.toggleisOpenHasLeaderRoleOrganizationDialog)
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case .setCurrentPage(let page):
            state.currentPage = page
            
        case .toggleisOpenHasLeaderRoleOrganizationDialog:
            state.isOpenHasLeaderRoleOrganizationDialog.toggle()
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
            .flatMapLatest { [weak self] action -> Observable<Void> in
                guard let self = self else { return .empty() }

                switch action {
                case .tapCompleteButton:
                    let newAnnouncement = NewAnnouncementEntity(
                        organizationId: Int64(selectOrganizationReactor.currentState.selectedOrganization?.id ?? 0), // 옵셔널 핸들링 필요
                        imageURL: "", // 추후 프로모션 페이지 사용하면서 추가
                        createdAt: .now,
                        title: editContentsReactor.currentState.title,
                        body: editContentsReactor.currentState.body,
                        endAt: editDateTimeReactor.currentState.selectedDate,
                        place: .init(
                            type: editPlaceReactor.currentState.placeType,
                            name: editPlaceReactor.currentState.placeName,
                            link: editPlaceReactor.currentState.placeLink
                        ),
                        todos: editTodoReactor.currentState.todos.map {
                            $0.content
                        },
                        notifications: Array(editNotificationReactor.currentState.selectedTimeOptions)
                    )
                    
                    ProgressHUD.animate(
                        nil,
                        .horizontalDotScaling,
                        interaction: false
                    )
                    
                    return self.createAnnouncementUsecase
                        .execute(.init(newAnnouncement: newAnnouncement))
                        .map { _ in
                            ProgressHUD.dismiss()
                            
                            return Void()
                        }
                        
                default:
                    return .empty()
                }
            }
            .subscribe(onNext: { [weak self] _ in
                self?.action.onNext(.moveNextPage)
            }, onError: { error in
                // 에러 핸들링 추가 필요
                print("Error: \(error)")
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
