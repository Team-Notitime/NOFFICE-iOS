public enum Module {
    public enum MainApp: String, CaseIterable {
        case noffice = "Noffice"
        
        var name: String { rawValue }
    }
    
    public enum Present: String, CaseIterable {
        case home = "Home"
        case organization = "Organization"
        case mypage = "Mypage"
        case signup = "Signup"
        
        var name: String { rawValue }
    }

    public enum UI: String, CaseIterable {
        case designSystem = "DesignSystem"
        case assets = "Assets"
        
        var name: String { rawValue }
    }

    public enum Example: String, CaseIterable {
        case home = "Home"
        case organization = "Organization"
        case mypage = "Mypage"
        case signup = "Signup"
        
        var name: String { rawValue }
    }

    public enum Domain: String, CaseIterable {
        case common = "Common"
        
        var name: String { rawValue }
    }

    public enum DataInterface: String, CaseIterable {
        case sample = "Sample"
        
        var name: String { rawValue }
    }

    public enum Data: String, CaseIterable {
        case sample = "Sample"
        
        var name: String { rawValue }
    }

    public enum DI: String, CaseIterable {
        case container = "Container"
        case router = "Router"
        
        var name: String { rawValue }
    }
    
    public enum ThirdParty: String, CaseIterable {
        case swinject = "Swinject"
        case rxSwift = "RxSwift"
        case rxCocoa = "RxCocoa"
        case snapKit = "SnapKit"
        case then = "Then"
        case alamofire = "Alamofire"
        
        var name: String { rawValue }
    }
}
