//
//  EditLocationReactor.swift
//  NewAnnouncementPresent
//
//  Created by DOYEON LEE on 7/22/24.
//

import ReactorKit

import AnnouncementUsecase
import AnnouncementEntity

class EditLocationReactor: Reactor {
    // MARK: Action
    enum Action { 
        case changeLocationName(String)
        case changeLocationLink(String)
    }
    
    enum Mutation { 
        case setLocationName(String)
        case setLocationLink(String)
        case setOpenGraph(OpenGraphEntity?)
    }
    
    // MARK: State
    struct State { 
        var locationName: String = ""
        var locationLink: String = ""
        var openGraph: OpenGraphEntity?
    }
    
    let initialState: State = State()
    
    // MARK: ChildReactor
    
    // MARK: Dependency
    private let fetchOpenGraphUsecase = FetchOpenGraphUsecase()
    
    // MARK: DisposeBag
    private let disposeBag = DisposeBag()
    
    // MARK: Initializer
    init() { }
    
    // MARK: Action operation
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case let .changeLocationName(name):
            return .just(.setLocationName(name))
            
        case let .changeLocationLink(link):
            let setLocationLinkMutation = Observable.just(Mutation.setLocationLink(link))
            
            let fetchOpenGraphMutation = fetchOpenGraphUsecase.execute(url: link)
                .map { Mutation.setOpenGraph($0) }
                .catchAndReturn(.setOpenGraph(nil))
            
            return .concat([
                setLocationLinkMutation,
                .just(Mutation.setOpenGraph(nil)), // Clear previous OpenGraph while fetching new one
                fetchOpenGraphMutation
                    .debounce(.milliseconds(300), scheduler: MainScheduler.instance) // Adjust debounce duration as needed
            ])
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case let .setLocationName(name):
            state.locationName = name
            
        case let .setLocationLink(link):
            state.locationLink = link
            
        case let .setOpenGraph(openGraph):
            state.openGraph = openGraph
        }
        return state
    }
    
    // MARK: Child bind
    private func setupChildBind() { }
    
    // MARK: Transform
    
    // MARK: Private method
}
