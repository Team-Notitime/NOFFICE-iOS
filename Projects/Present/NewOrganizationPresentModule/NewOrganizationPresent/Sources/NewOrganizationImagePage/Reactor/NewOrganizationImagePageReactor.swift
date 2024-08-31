//
//  NewOrganizationImagePageReactor.swift
//  OrganizationPresent
//
//  Created by DOYEON LEE on 7/19/24.
//

import UIKit

import CommonEntity
import CommonUsecase
import OrganizationEntity

import ReactorKit
import ProgressHUD

class NewOrganizationImagePageReactor: Reactor {
    // MARK: Action
    enum Action {
        case changeSelectedImage(ImageEntity)
        case deleteSelectedImage
        case tapNextPageButton
    }
    
    enum Mutation {
        case setSelectedImage(ImageEntity?)
        case setUploadedUrl(URL?)
    }
    
    // MARK: State
    struct State {
        var selectedImage: ImageEntity?
        var uploadedUrl: URL?
    }
    
    let initialState: State = State()
    
    // MARK: Dependency
    private let uploadImageUsecase = UploadImageUsecase()
    
    // MARK: DisposeBag
    private let disposeBag = DisposeBag()
    
    // MARK: Initializer
    init() { }
    
    // MARK: Action operation
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case let .changeSelectedImage(image):
            ProgressHUD.animate(nil, .horizontalDotScaling, interaction: false)
            let uploadImageObservable = uploadImageUsecase.execute(
                .init(
                    image: image,
                    imagePurpose: .organizationLogo
                )
            )
            .flatMap { output in
                ProgressHUD.dismiss()
                return Observable.merge(
                    .just(Mutation.setSelectedImage(image)),
                    .just(Mutation.setUploadedUrl(output.url))
                )
            }

            return uploadImageObservable

        case .tapNextPageButton:
            // pass to parent
            return .empty()
            
        case .deleteSelectedImage:
            return .just(Mutation.setSelectedImage(nil))
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case let .setSelectedImage(image):
            state.selectedImage = image
            
        case let .setUploadedUrl(url):
            state.uploadedUrl = url
        }
        return state
    }
}
