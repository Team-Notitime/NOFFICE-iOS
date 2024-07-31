//
//  OrganizationRepositoryInterface.swift
//  OrganizationDataInterface
//
//  Created by DOYEON LEE on 7/31/24.
//

import RxSwift
import OrganizationEntity

/// A protocol defining the operations for managing organizations.
public protocol OrganizationRepositoryInterface {
    
    /// Creates a new organization.
    ///
    /// - Parameter organization: The organization entity containing the details of the organization to be created.
    /// - Returns: An Observable that emits the created OrganizationEntity upon successful creation. 
    /// If the request fails, it emits an ``OrganizationError``.
    func createOrganization(
        organization: NewOrganizationEntity
    ) -> Observable<OrganizationEntity>
    
    /// Retrieves the details of a specific organization.
    ///
    /// - Parameter id: The unique identifier of the organization to retrieve.
    /// - Returns: An Observable that emits the OrganizationEntity containing the details of the requested organization. 
    /// If the request fails, it emits an ``OrganizationError``.
    func getOrganization(id: Int) -> Observable<OrganizationEntity>
    
    /// Sends a request for a user to join an organization.
    ///
    /// - Parameters:
    ///   - organizationId: The unique identifier of the organization the user wants to join.
    ///   - userId: The unique identifier of the user who wants to join the organization.
    /// - Returns: An Observable that emits a Boolean value indicating whether the join operation was successful. If the request fails, it emits an ``OrganizationError``.
    func joinOrganization(organizationId: Int, userId: Int) -> Observable<Bool>
    
    /// Retrieves a list of all organizations.
    ///
    /// - Returns: An Observable that emits an array of OrganizationEntity objects, each representing an organization. 
    /// If the request fails, it emits an ``OrganizationError``.
    func getOrganizationList() -> Observable<[OrganizationEntity]>
}
