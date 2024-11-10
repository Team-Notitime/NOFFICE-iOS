//
//  KakaoSdkConfig.swift
//  Noffice
//
//  Created by DOYEON LEE on 11/10/24.
//

import Foundation

import KakaoSDKCommon
import RxKakaoSDKCommon

struct KakaoSdkConfig {
    static func setup() {
        if let nativeAppKey = Bundle.module.object(forInfoDictionaryKey: "KAKAO_NATIVE_APP_KEY") as? String {
            KakaoSDK.initSDK(appKey: nativeAppKey)
            RxKakaoSDK.initSDK(appKey: nativeAppKey)
            print("KakaoSDK init success, appKey: \(nativeAppKey)")
        }
    }
}
