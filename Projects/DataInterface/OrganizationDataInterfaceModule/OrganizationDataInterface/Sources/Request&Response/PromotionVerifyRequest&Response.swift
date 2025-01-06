//
//  PromotionVerifyRequest&Response.swift
//  OrganizationDataInterface
//
//  Created by HUNHEE LEE on 3.01.2025.
//

import OpenapiGenerated

// MARK: Request
public struct PromotionVerifyRequest {
  public let body: Components.Schemas.PromotionVerifyRequest
  
  public init(
    body: Components.Schemas.PromotionVerifyRequest
  ) {
    self.body = body
  }
}

// MARK: Response
public typealias PromotionVerifyResponse = Components.Schemas.PromotionVerifyResponse
