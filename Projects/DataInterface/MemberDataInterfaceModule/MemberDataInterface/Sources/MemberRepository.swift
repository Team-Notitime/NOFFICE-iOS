//
//  MemberRepository.swift
//  MemberDataInterface
//
//  Created by DOYEON LEE on 8/12/24.
//

import OpenapiGenerated
import RxSwift

public protocol MemberRepositoryInterface {
    func getMember(_ request: GetMemberRequest) -> Observable<GetMemberResponse>

    func login(_ request: LoginRequest) -> Observable<LoginResponse>

    func reissue(_ request: ReissueRequest) -> Observable<ReissueResponse>

    func withdrawal(_ request: WithdrawalRequest) -> Observable<WithdrawalResponse>
}
