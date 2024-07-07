public enum Module {
    public enum MainApp: String, CaseIterable {
        case noffice = "Noffice"
        
        var name: String { rawValue }
    }
    
    public enum Feature: String, CaseIterable {
        case home = "Home"
        case organization = "Organization"
        case mypage = "Mypage"
        case signup = "Signup"
        
        var name: String { rawValue }
    }

    public enum UI: String, CaseIterable {
        case designSystem = "DesignSystem"
        
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
}
