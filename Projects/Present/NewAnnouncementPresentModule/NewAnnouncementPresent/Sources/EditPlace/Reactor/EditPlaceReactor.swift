//
//  EditLocationReactor.swift
//  NewAnnouncementPresent
//
//  Created by DOYEON LEE on 7/22/24.
//

import AnnouncementEntity
import CommonUsecase
import CommonEntity

import ReactorKit

class EditPlaceReactor: Reactor {
    // MARK: Action
    enum Action { 
        case changePlaceType(AnnouncementPlaceType)
        case changePlaceName(String)
        case changePlaceLink(String)
    }
    
    enum Mutation { 
        case setPlaceType(AnnouncementPlaceType)
        case setPlaceName(String)
        case setPlaceLink(String)
        case setOpenGraph(OpenGraphEntity?)
        case setisURLError(Bool)
    }
    
    // MARK: State
    struct State { 
        var placeType: AnnouncementPlaceType = .online
        var placeName: String = ""
        var placeLink: String = ""
        var openGraph: OpenGraphEntity?
        var isURLError: Bool = false
    }
    
    let initialState: State = State()
    
    // MARK: ChildReactor
    
    // MARK: Dependency
    private let fetchOpenGraphUsecase = FetchOpenGraphUsecase()
    
    private let validateURLUsecase = ValidateURLUsecase()
    
    // MARK: DisposeBag
    private let disposeBag = DisposeBag()
    
    // MARK: Initializer
    init() { }
    
    // MARK: Action operation
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case let .changePlaceType(place):
            return .just(.setPlaceType(place))
            
        case let .changePlaceName(name):
            return .just(.setPlaceName(name))
            
        case let .changePlaceLink(link):
            if link.isEmpty {
                return .merge(
                    .just(.setOpenGraph(nil)),
                    .just(.setisURLError(false))
                )
            }
            
            if !validateURLUsecase.execute(url: link) {
                return .merge(
                    .just(.setOpenGraph(nil)),
                    .just(.setisURLError(true))
                )
            }
            
            let setPlaceLinkMutation = Observable.just(Mutation.setPlaceLink(link))
            
            let fetchOpenGraphMutation = fetchOpenGraphUsecase.execute(url: link)
                .map { Mutation.setOpenGraph($0) }
                .catchAndReturn(.setOpenGraph(nil))
            
            return .concat([
                .just(.setisURLError(false)),
                setPlaceLinkMutation,
                .just(Mutation.setOpenGraph(nil)), // Clear previous OpenGraph while fetching new one
                fetchOpenGraphMutation
                    .debounce(.milliseconds(300), scheduler: MainScheduler.instance)
            ])
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case let .setPlaceType(place):
            state.placeType = place
            
        case let .setPlaceName(name):
            state.placeName = name
            
        case let .setPlaceLink(link):
            state.placeLink = link
            
        case let .setOpenGraph(openGraph):
            print("setOpenGraph \(openGraph)")
            state.openGraph = openGraph
            if let openGraph = openGraph {
                state.placeName = openGraph.title
            }
            
        case let .setisURLError(isError):
            state.isURLError = isError
        }
        return state
    }
    
    // MARK: Child bind
    private func setupChildBind() { }
    
    // MARK: Transform
    
    // MARK: Private method

}
