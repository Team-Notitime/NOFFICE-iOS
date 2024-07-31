//
//  OrganizationRepository.swift
//  OrganizationData
//
//  Created by DOYEON LEE on 7/29/24.
//

import OrganizationEntity
import OrganizationDataInterface
import CommonData

import RxSwift
import RxMoya
import Moya

/// A repository that handles network communication with the server related to the organization domain.
public struct OrganizationRepository: OrganizationRepositoryInterface {
    private let provider = MoyaProvider<OrganizationTarget>()

    public func createOrganization(
        organization: OrganizationEntity
    ) -> Observable<OrganizationEntity> {
        let requestDTO = CreateOrganizationConverter.convert(from: organization)
        
        return provider.rx.request(.createOrganization(requestDTO))
            .catch { error -> Single<Response> in
                return .error(OrganizationError.underlying(error))
            }
            .filterSuccessfulStatusCodes()
            .map(BaseResponse<CreateOrganizationDTO.Response>.self)
            .map(CreateOrganizationConverter.convert)
            .asObservable()
    }

    public func getOrganization(id: Int) -> Observable<OrganizationEntity> {
        return provider.rx.request(.getOrganization(id: id))
            .catch { error -> Single<Response> in
                return .error(OrganizationError.underlying(error))
            }
            .filterSuccessfulStatusCodes()
            .map(BaseResponse<GetOrganizationDTO.Response>.self)
            .map(GetOrganizationConverter.convert)
            .asObservable()
    }
    
    public func joinOrganization(
        organizationId: Int,
        userId: Int
    ) -> Observable<Bool> {
        return provider.rx.request(.joinOrganization(organizationId: organizationId, userId: userId))
            .catch { error -> Single<Response> in
                return .error(OrganizationError.underlying(error))
            }
            .filterSuccessfulStatusCodes()
            .map(BaseResponse<JoinOrganizationDTO.Response>.self)
            .map(JoinOrganizationConverter.convert)
            .asObservable()
    }
    
    public func getOrganizationList() -> Observable<[OrganizationEntity]> {
        return provider.rx.request(.getOrganizationList)
            .catch { error -> Single<Response> in
                return .error(OrganizationError.underlying(error))
            }
            .filterSuccessfulStatusCodes()
            .map(BaseResponse<GetOrganizationListDTO.Response>.self)
            .map(GetOrganizationListConverter.convert)
            .asObservable()
    }
}
