//
//  TermOptionType.swift
//  MainDomainModule
//
//  Created by DOYEON LEE on 18.07.2024.
//

public enum TermOptionType: Int, CaseIterable {
  case age = 0
  case service = 1
  case personal = 2
  case marketing = 3
  
  public var termOption: TermOption {
    switch self {
    case .age:
      return .init(
        type: self,
        order: rawValue,
        text: "(필수) 만 14세 이상입니다.",
        required: true
      )
    case .service:
      return .init(
        type: self,
        order: rawValue,
        text: "(필수) 서비스 이용약관 동의",
        termFile: .init(
          title: "서비스 이용약관",
          fileName: "service_of_terms"
        ),
        required: true
      )
    case .personal:
      return .init(
        type: self,
        order: rawValue,
        text: "(필수) 개인정보 처리방침 동의",
        termFile: .init(
          title: "개인정보 처리방침",
          fileName: "privacy_policy"
        ),
        required: true
      )
    case .marketing:
      return .init(
        type: self,
        order: rawValue,
        text: "(선택) 마케팅 수신 동의",
        termFile: .init(
          title: "마케팅 수신 동의",
          fileName: "marketing"
        ),
        required: false
      )
    }
  }
}

public struct TermOption: Identifiable, Equatable {
  public let type: TermOptionType?
  public let order: Int
  public let text: String
  public let description: String?
  public let termFile: TermFile?
  public let required: Bool
  
  public init(
    type: TermOptionType? = nil,
    order: Int = -1,
    text: String,
    description: String? = nil,
    termFile: TermFile? = nil,
    required: Bool = false
  ) {
    self.type = type
    self.order = order
    self.text = text
    self.description = description
    self.termFile = termFile
    self.required = required
  }
  
  public var id: String {
    return text
  }
}

public struct TermFile: Equatable {
  public let title: String
  public let fileName: String
  
  public init(
    title: String,
    fileName: String
  ) {
    self.title = title
    self.fileName = fileName
  }
}
