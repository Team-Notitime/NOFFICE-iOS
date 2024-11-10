//
//  KakaoLoginUsecase.swift
//  MemberUsecase
//
//  Created by DOYEON LEE on 11/10/24.
//

import Foundation

import MemberDataInterface

import RxSwift
import KakaoSDKCommon
import RxKakaoSDKCommon
import KakaoSDKUser
import RxKakaoSDKUser
import Swinject

public struct KakaoLoginUsecase {
    public struct Input {
        public init() { }
    }
    
    public struct Output { }
    
    public enum Error: LocalizedError {
        case kakaoTalkIsNotAvailable
        case unknownError
    }
    
    public init() { }
    
    private let memberRepository = Container.shared.resolve(MemberRepositoryInterface.self)!
    
    public func execute(_ input: Input) -> Observable<Output> {
        
        if let nativeAppKey = Bundle.main.object(forInfoDictionaryKey: "KAKAO_NATIVE_APP_KEY") as? String {
            KakaoSDK.initSDK(appKey: nativeAppKey)
            RxKakaoSDK.initSDK(appKey: nativeAppKey)
        } else {
            return Observable.error(Error.unknownError)
        }
        
        if UserApi.isKakaoTalkLoginAvailable() {
            return UserApi.shared.rx.loginWithKakaoTalk()
                .map { oauthToken in
                    let token = oauthToken
                    memberRepository.login(
                        .init(body: .json(.init(provider: .KAKAO, code: token)))
                    )
                    print("token: \(token)")
                    return Output()
                }
                .catch { error in
                    print("Error occurred: \(error)")
                    return Observable.error(Error.unknownError)
                }
        } else {
            return Observable.error(Error.kakaoTalkIsNotAvailable)
        }
    }
}
