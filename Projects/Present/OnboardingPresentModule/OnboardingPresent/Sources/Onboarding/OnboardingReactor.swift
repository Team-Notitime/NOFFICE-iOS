//
//  OnboardingReactor.swift
//  OnboardingPresent
//
//  Created by HUNHEE LEE on 22.12.2024.
//

import ReactorKit
import Combine

public final class Event<T> {
  public let value: T
  
  public init(_ value: T) {
    self.value = value
  }
}

public final class OnboardingReactor: Reactor {
  public enum Action {
    case nextButtonTapped
    case pageChanged(Int)
  }
  
  public enum Mutation {
    case setCurrentPage(Int)
    case setButtonTitle(String)
    case setFinishOnboarding(Event<Void>)
  }
  
  public struct State {
    let pages: [OnboardingPage] = [
      OnboardingPage(
        id: 0,
        title: "일일히 작성해서\n귀찮았던 공지는 그만!",
        content: "줄 나누기, 이모지, 더 이상 필요없어요!\n내가 원하는 내용만 담아서 가독성 좋게 전달할 수 있어요",
        imageName: "onboarding_1"
      ),
      OnboardingPage(
        id: 1,
        title: "안 읽어서 답답했던\n단체생활 공지는 이제 안녕!",
        content: "읽은 사람과 안 읽은 사람을 한 눈에 볼 수 있어요",
        imageName: "onboarding_2"
      ),
      OnboardingPage(
        id: 2,
        title: "동아리, 스터디, 소모임\n어떤 단체든 알차게 활용해요",
        content: "리더에게는 더욱 편리한 공지 발행 과정을,\n멤버에게는 복잡하지 않은 공지를 선물할게요",
        imageName: "onboarding_3"
      )
    ]
    var currentPage: Int = 0
    var buttonTitle: String = "다음"
    var finishOnboarding: Event<Void>?
  }
  
  public let initialState: State = State()
  
  public init() { }
}

extension OnboardingReactor {
  public func mutate(action: Action) -> Observable<Mutation> {
    switch action {
    case .nextButtonTapped:
      let nextPage = currentState.currentPage + 1
      if nextPage < currentState.pages.count {
        return .concat([
          .just(.setCurrentPage(nextPage)),
          .just(.setButtonTitle(nextPage == currentState.pages.count - 1 ? "시작하기" : "다음"))
        ])
      } else {
        return .just(.setFinishOnboarding(.init(Void())))
      }
    case let .pageChanged(page):
      return .concat([
        .just(.setCurrentPage(page)),
        .just(.setButtonTitle(page == currentState.pages.count - 1 ? "시작하기" : "다음"))
      ])
    }
  }
  
  public func reduce(state: State, mutation: Mutation) -> State {
    var newState = state
    
    switch mutation {
    case let .setCurrentPage(page):
      newState.currentPage = page
    case let .setButtonTitle(title):
      newState.buttonTitle = title
    case let .setFinishOnboarding(event):
      newState.finishOnboarding = event
    }
    
    return newState
  }
}

final class OnboardingStateContainer: ObservableObject {
  private let reactor: OnboardingReactor
  private var disposeBag = DisposeBag()
  
  @Published var currentPage: Int = 0
  @Published var buttonTitle: String = "다음"
  let pages: [OnboardingPage]
  
  init(reactor: OnboardingReactor) {
    self.reactor = reactor
    self.pages = reactor.currentState.pages
    
    reactor.state
      .map(\.currentPage)
      .distinctUntilChanged()
      .bind { [weak self] page in
        self?.currentPage = page
      }
      .disposed(by: disposeBag)
    
    reactor.state
      .map(\.buttonTitle)
      .distinctUntilChanged()
      .bind { [weak self] title in
        self?.buttonTitle = title
      }
      .disposed(by: disposeBag)
  }
  
  func nextButtonTapped() {
    reactor.action.onNext(.nextButtonTapped)
  }
  
  func pageChanged(_ page: Int) {
    reactor.action.onNext(.pageChanged(page))
  }
}
