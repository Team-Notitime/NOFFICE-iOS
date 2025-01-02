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

public final class SignupTermsPageReactor: Reactor {
  // MARK: Action
  public enum Action {
    case tapNextPageButton
    case tapBackButton
    case changeSelectedTermOptions([TermOptionType])
    case dismissTermsDetail
  }
  
  public enum Mutation {
    case setSelectedTermOptions([TermOptionType])
    case changeNextButtonActive([TermOptionType])
    case setTermsDetailVisible(Bool)
  }
  
  // MARK: State
  public struct State {
    var selectedTermOptions: [TermOptionType] = []
    var nextButtonActive: Bool = false
    var termsDetailVisible: Bool = false
  }
  
  public let initialState: State = State()
  
  // MARK: Initializer
  init() {  }
  
  // MARK: Action operation
  public func mutate(action: Action) -> Observable<Mutation> {
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
    case .dismissTermsDetail:
      return .just(.setTermsDetailVisible(false))
    }
  }
  
  public func reduce(state: State, mutation: Mutation) -> State {
    var state = state
    switch mutation {
    case let .setSelectedTermOptions(options):
      state.selectedTermOptions = options
      
    case let .changeNextButtonActive(options):
      let nextButtonActive = checkSelectedAllRequiredTermOptions(
        options
      )
      state.nextButtonActive = nextButtonActive
    case let .setTermsDetailVisible(visible):
      state.termsDetailVisible = visible
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

public final class SignupTermsDetailContainer: ObservableObject {
  private let reactor: SignupTermsPageReactor
  private var disposeBag = DisposeBag()
  
  @Published var isPresented: Bool = false
  
  public init(reactor: SignupTermsPageReactor) {
    self.reactor = reactor
    
    reactor.state
      .map(\.termsDetailVisible)
      .distinctUntilChanged()
      .bind { [weak self] visible in
        self?.isPresented = visible
      }
      .disposed(by: disposeBag)
  }
  
  func dismiss() {
    reactor.action.onNext(.dismissTermsDetail)
  }
}
