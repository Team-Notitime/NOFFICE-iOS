//
//  GetAnnouncementsByOrganizationUsecase.swift
//  AnnouncementUsecase
//
//  Created by DOYEON LEE on 8/19/24.
//

import Foundation

import Container
import OrganizationEntity
import AnnouncementEntity
import OrganizationDataInterface

import Swinject
import RxSwift

public final class GetAnnouncementsByOrganizationUsecase {
    // MARK: DTO
    public struct Input {
        public let organizationId: Int64
        
        public init(organizationId: Int64) {
            self.organizationId = organizationId
        }
    }
    
    public struct Output {
        public let announcements: [AnnouncementSummaryEntity]
    }
    
    // MARK: Error
    public enum Error: LocalizedError {
        case contentFieldNotFound
    }
    
    // MARK: Dependency
    private let internalUsecase = _GetAnnouncementsByOrganizationUsecase()
    
    // MARK: Initializer
    public init() {}
    
    // MARK: Execute method
    public func execute(_ input: Input) -> Observable<Output> {
        let internalInput = _GetAnnouncementsByOrganizationUsecase.Input(
            organizationId: input.organizationId
        )
        
        return internalUsecase.execute(internalInput)
            .map { internalOutput in
                return Output(announcements: internalOutput.announcements)
            }
            .catch { error in
                // Error handling
                if let internalError = error as? _GetAnnouncementsByOrganizationUsecase.Error {
                    switch internalError {
                    case .contentFieldNotFound:
                        return Observable.error(Error.contentFieldNotFound)
                    }
                }
                return Observable.error(error)
            }
    }
}
