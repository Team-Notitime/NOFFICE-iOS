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

/// A repository that handles network communication with the server related to the organization domain.
public struct OrganizationRepository {
    private let provider = MoyaProvider<OrganizationTarget>()

    /// Creates a new organization.
    ///
    /// This function sends a request to create a new organization based on the provided entity.
    /// If the request fails, the error is caught and converted into an ``OrganizationError``.
    ///
    /// - Parameter organization: The organization entity containing the details of the organization to be created.
    /// - Returns: An Observable that emits the created OrganizationEntity upon successful creation.
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

    /// Retrieves the details of a specific organization.
    ///
    /// This function fetches the details of an organization based on its ID.
    /// If the request fails, the error is caught and converted into an ``OrganizationError``.
    ///
    /// - Parameter id: The unique identifier of the organization to retrieve.
    /// - Returns: An Observable that emits the OrganizationEntity containing the details of the requested organization.
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
    
    /// Sends a request for a user to join an organization.
    ///
    /// This function initiates the process for a user to join a specific organization.
    /// If the request fails, the error is caught and converted into an ``OrganizationError``.
    ///
    /// - Parameters:
    ///   - organizationId: The unique identifier of the organization the user wants to join.
    ///   - userId: The unique identifier of the user who wants to join the organization.
    /// - Returns: An Observable that emits a Boolean value indicating whether the join operation was successful.
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
    
    /// Retrieves a list of all organizations.
    ///
    /// This function fetches a list of all available organizations.
    /// If the request fails, the error is caught and converted into an ``OrganizationError``.
    ///
    /// - Returns: An Observable that emits an array of OrganizationEntity objects, each representing an organization.
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
