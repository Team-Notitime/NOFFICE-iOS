//
//  ValidateURLUsecase.swift
//  CommonUsecase
//
//  Created by DOYEON LEE on 8/2/24.
//

import Foundation

public struct ValidateURLUsecase {
    
    public init() { }
    
    public func execute(url: String) -> Bool {
        let regex = "^(https?|ftp)://[\\w-]+(\\.[\\w-]+)+(:\\d+)?(/[\\w- .?%&=]*)?$"
        
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: url)
    }
}
