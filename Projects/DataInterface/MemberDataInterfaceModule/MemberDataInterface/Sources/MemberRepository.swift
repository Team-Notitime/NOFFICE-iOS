//
//  MemberRepository.swift
//  MemberDataInterface
//
//  Created by DOYEON LEE on 8/12/24.
//

import OpenapiGenerated

import RxSwift

public typealias GetMemberParam = Operations.getById.Input
public typealias GetMemberResult = Components.Schemas.MemberResponse

public typealias LoginParam = Operations.login.Input
public typealias LoginResult = Components.Schemas.SocialAuthResponse

public typealias ReissueParam = Operations.reissue.Input
public typealias ReissueResult = Components.Schemas.TokenResponse

public protocol MemberRepositoryInterface { 
    func getMember(_ param: GetMemberParam) -> Observable<GetMemberResult>
    
    func login(_ param: LoginParam) -> Observable<LoginResult>
    
    func reissue(_ param: ReissueParam) -> Observable<ReissueResult>
}
