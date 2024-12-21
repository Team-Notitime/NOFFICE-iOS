//
//  ImageMetaEntity.swift
//  CommonEntity
//
//  Created by DOYEON LEE on 8/25/24.
//

import Foundation

public struct ImageEntity {
    public let url: URL
    public let data: Data
    
    public init(
        url: URL,
        data: Data
    ) {
        self.url = url
        self.data = data
    }
}
