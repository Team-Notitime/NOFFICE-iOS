//
//  MemberEntity.swift
//  MemberEntity
//
//  Created by DOYEON LEE on 8/2/24.
//

import Foundation

/// Represents a member entity with basic user information.
public struct MemberEntity {
    /// The unique identifier for the member.
    public let uid: Int
    
    /// The name of the member.
    public let name: String
    
    /// The email address of the member.
    public let email: String
    
    /// The URL of the member's profile image, if available.
    public let profileImageURL: String?
    
    public init(
        uid: Int,
        name: String,
        email: String,
        profileImageURL: String? = nil
    ) {
        self.uid = uid
        self.name = name
        self.email = email
        self.profileImageURL = profileImageURL
    }
}
