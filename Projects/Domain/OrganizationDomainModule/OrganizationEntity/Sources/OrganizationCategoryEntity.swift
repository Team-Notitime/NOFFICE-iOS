//
//  OrganizationCategoryEntity.swift
//  OrganizationEntity
//
//  Created by DOYEON LEE on 7/19/24.
//

import Foundation

/** 
 The category of group.
 
 Choose when creating a group.
 */
public struct OrganizationCategoryEntity: Codable, Identifiable, Equatable {
    /// Category unique ID
    public let id: Int
    
    /// Category kr name
    public let name: String
    
    public init(
        id: Int,
        name: String
    ) {
        self.id = id
        self.name = name
    }
}

/**
 Types of group categories.
 
 - See Also: ``OrganizationCategoryEntity``
 */
public enum OrganizationCategoryType: String, CaseIterable {
    case informationTechnology = "IT 계열"
    case culture = "문화생활"
    case language = "어학"
    case arts = "예술"
    case musicPerformance = "음악·공연"
    case studyResearch = "스터디·연구"
    case sports = "스포츠"
    case startup = "창업"
    case religion = "종교"
    case marketingPromotion = "마케팅·홍보"
    case naturalScience = "자연과학"
    case etc = "기타"
    
    public func toEntity() -> OrganizationCategoryEntity {
        let index = OrganizationCategoryType.allCases.firstIndex(of: self) ?? 0
        return OrganizationCategoryEntity(id: index, name: self.rawValue)
    }
}
