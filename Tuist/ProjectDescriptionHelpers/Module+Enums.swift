public enum Module {
    public enum MainApp: String, CaseIterable {
        case noffice = "Noffice"
        
        var name: String { rawValue }
        var bundleIdenifier: String { rawValue.toBundleIdentifier() }
    }
    
    public enum Present: String, CaseIterable {
        case home = "Home"
        case organization = "Organization"
        case mypage = "Mypage"
        case signup = "Signup"
        case newAnnouncement = "NewAnnouncement"
        
        var name: String { rawValue }
        var bundleIdenifier: String { rawValue.toBundleIdentifier() }
    }

    public enum UI: String, CaseIterable {
        case designSystem = "DesignSystem"
        case assets = "Assets"
        
        var name: String { rawValue }
        var bundleIdenifier: String { rawValue.toBundleIdentifier() }
    }

    public enum Example: String, CaseIterable {
        case home = "Home"
        case organization = "Organization"
        case mypage = "Mypage"
        case signup = "Signup"
        
        var name: String { rawValue }
        var bundleIdenifier: String { rawValue.toBundleIdentifier() }
    }

    public enum Domain: String, CaseIterable {
        case common = "Common"
        case organization = "Organization"
        case todo = "Todo"
        case announcement = "Announcement"
        
        var name: String { rawValue }
        var bundleIdenifier: String { rawValue.toBundleIdentifier() }
    }

    public enum DataInterface: String, CaseIterable {
        case sample = "Sample"
        
        var name: String { rawValue }
        var bundleIdenifier: String { rawValue.toBundleIdentifier() }
    }

    public enum Data: String, CaseIterable {
        case sample = "Sample"
        
        var name: String { rawValue }
        var bundleIdenifier: String { rawValue.toBundleIdentifier() }
    }

    public enum DI: String, CaseIterable {
        case container = "Container"
        case router = "Router"
        
        var name: String { rawValue }
        var bundleIdenifier: String { rawValue.toBundleIdentifier() }
    }
    
    public enum ThirdParty: String, CaseIterable {
        case swinject = "Swinject"
        case rxSwift = "RxSwift"
        case rxCocoa = "RxCocoa"
        case rxGesture = "RxGesture"
        case snapKit = "SnapKit"
        case then = "Then"
        case reactorKit = "ReactorKit"
        case alamofire = "Alamofire"
        
        var name: String { rawValue }
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
}
