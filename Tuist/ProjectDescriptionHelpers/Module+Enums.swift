public enum Module {
    public enum MainApp: String, CaseIterable {
        case noffice
        
        var name: String { rawValue.toUpperCamelCase() }
        var bundleIdenifier: String { rawValue.toBundleIdentifier() }
    }
    
    public enum Present: String, CaseIterable {
        case home
        case organization
        case newOrganization
        case mypage
        case signup
        case announcement
        case newAnnouncement
        
        var name: String { rawValue.toUpperCamelCase() }
        var bundleIdenifier: String { rawValue.toBundleIdentifier() }
    }

    public enum UI: String, CaseIterable {
        case designSystem
        case assets
        
        var name: String { rawValue.toUpperCamelCase() }
        var bundleIdenifier: String { rawValue.toBundleIdentifier() }
    }

    public enum Example: String, CaseIterable {
        case home
        case newOrganization
        case organization
        case mypage
        case signup
        case announcement
        case newAnnouncement
        
        var name: String { rawValue.toUpperCamelCase() }
        var bundleIdenifier: String { rawValue.toBundleIdentifier() }
    }

    public enum Domain: String, CaseIterable {
        case common
        case organization
        case todo
        case announcement
        case member
        
        var name: String { rawValue.toUpperCamelCase() }
        var bundleIdenifier: String { rawValue.toBundleIdentifier() }
    }

    public enum DataInterface: String, CaseIterable {
        case sample
        case organization
        case announcement
        case member
        
        var name: String { rawValue.toUpperCamelCase() }
        var bundleIdenifier: String { rawValue.toBundleIdentifier() }
    }

    public enum Data: String, CaseIterable {
        case common
        case organization
        case announcement
        case member
        
        var name: String { rawValue.toUpperCamelCase() }
        var bundleIdenifier: String { rawValue.toBundleIdentifier() }
    }

    public enum DI: String, CaseIterable {
        case container
        case router
        
        var name: String { rawValue.toUpperCamelCase() }
        var bundleIdenifier: String { rawValue.toBundleIdentifier() }
    }
    
    public enum Utility: String, CaseIterable {
        case keychain
        
        var name: String { rawValue.toUpperCamelCase() }
        var bundleIdenifier: String { rawValue.toBundleIdentifier() }
    }
    
    public enum ThirdParty: String, CaseIterable {
        case swinject
        case rxSwift
        case rxCocoa
        case rxGesture
        case snapKit
        case then
        case reactorKit
        case kingfisher
        case openGraph
        case skeletonView
        case moya
        case rxMoya
        case openapiGenerated
        
        var name: String { rawValue.toUpperCamelCase() }
    }
}

// MARK: - Helper
extension String {
    func toBundleIdentifier() -> String {
        var result = ""
        for (index, char) in self.enumerated() {
            if char.isUppercase {
                result += (index == 0 ? "" : "-") + char.lowercased()
            } else {
                result += String(char)
            }
        }
        return result
    }

    func toUpperCamelCase() -> String {
        return prefix(1).uppercased() + dropFirst()
    }
}
