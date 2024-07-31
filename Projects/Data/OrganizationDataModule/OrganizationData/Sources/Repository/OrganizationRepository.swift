//
//  OrganizationRepository.swift
//  OrganizationData
//
//  Created by DOYEON LEE on 7/29/24.
//

import OrganizationEntity
import CommonData

import RxSwift
import RxMoya
import Moya

public struct OrganizationRepository {
    private let provider = MoyaProvider<OrganizationTarget>()

    // Create an organization
    public func createOrganization(name: String) -> Observable<OrganizationEntity> {
        return provider.rx.request(.createOrganization(name: name))
            .filterSuccessfulStatusCodes()
            .map(BaseResponse<Organization>.self)
            .map(OrganizationConverter.convert)
            .asObservable()
    }
//
//    // Get organization details
//    public func getOrganization(id: Int) -> Observable<Organization> {
//        return provider.rx.request(.getOrganization(id: id))
//            .filterSuccessfulStatusCodes()
//            .map(Organization.self)
//            .asObservable()
//    }
//    
//    // Join an organization
//    public func joinOrganization(organizationId: Int, userId: Int) -> Observable<Response> {
//        return provider.rx.request(.joinOrganization(organizationId: organizationId, userId: userId))
//            .filterSuccessfulStatusCodes()
//            .asObservable()
//    }
//    
//    // Get list of organizations
//    public func getOrganizationList() -> Observable<[Organization]> {
//        return provider.rx.request(.getOrganizationList)
//            .filterSuccessfulStatusCodes()
//            .map([Organization].self)
//            .asObservable()
//    }
}
