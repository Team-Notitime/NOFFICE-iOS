//
//  HomeTabReactor.swift
//  HomePresent
//
//  Created by DOYEON LEE on 8/18/24.
//

import ReactorKit

class HomeTabReactor: Reactor {
    // MARK: Action
    enum Action { 
        case movePage(HomeTabView.Page) // TODO: 의존성 수정 위해서 Page 객체 도메인으로 이동 필요
    }
    
    enum Mutation { }
    
    // MARK: State
    struct State { }
    
    let initialState: State = State()
    
    // MARK: ChildReactor
    private let announcementPageReactor: AnnouncementPageReactor
    
    private let todoPageReactor: TodoPageReactor
    
    // MARK: Dependency
    
    // MARK: DisposeBag
    private let disposeBag = DisposeBag()
    
    // MARK: Initializer
    init(
        announcementPageReactor: AnnouncementPageReactor,
        todoPageReactor: TodoPageReactor
    ) {
        self.announcementPageReactor = announcementPageReactor
        self.todoPageReactor = todoPageReactor
    }
    
    // MARK: Action operation
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case let .movePage(page):
            switch page {
            case .announcement:
                announcementPageReactor.action.onNext(.viewWillAppear)
                
            case .todo:
                todoPageReactor.action.onNext(.viewWillAppear)
            }

            return .empty()
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation { }
        return state
    }
    
    // MARK: Child bind
    private func setupChildBind() { }
    
    // MARK: Transform
    
    // MARK: Private method
}
