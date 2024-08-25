//
//  GetImageUploadPathRequest&Response.swift
//  ImageDataInterface
//
//  Created by DOYEON LEE on 8/25/24.
//

import OpenapiGenerated

// MARK: Request
public typealias GetImageUploadPathRequest = Operations.getContentImage.Input.Query

// MARK: Response
public typealias GetImageUploadPathResponse = Components.Schemas.ContentImagePresignedUrlVO
