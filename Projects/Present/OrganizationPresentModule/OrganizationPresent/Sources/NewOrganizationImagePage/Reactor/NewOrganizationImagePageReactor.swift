//
//  NewOrganizationImagePageReactor.swift
//  OrganizationPresent
//
//  Created by DOYEON LEE on 7/19/24.
//

import UIKit

import OrganizationEntity

import ReactorKit

class NewOrganizationImagePageReactor: Reactor {
    // MARK: Action
    enum Action {
        case changeSelectedImage(UIImage?)
        case tapNextPageButton
    }
    
    enum Mutation {
        case setSelectedImage(UIImage?)
    }
    
    // MARK: State
    struct State {
        var selectedImage: UIImage?
        var nextPageButtonActive: Bool = false
    }
    
    let initialState: State = State()
    
    // MARK: DisposeBag
    private let disposeBag = DisposeBag()
    
    // MARK: Initializer
    init() { }
    
    // MARK: Action operation
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case let .changeSelectedImage(image):
            return .just(.setSelectedImage(image))
            
        case .tapNextPageButton:
            // pass to parent
            return .empty()
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case let .setSelectedImage(image):
            state.selectedImage = image
            state.nextPageButtonActive = image != nil
        }
        return state
    }
}
