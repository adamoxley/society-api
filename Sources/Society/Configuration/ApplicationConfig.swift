import Vapor

struct ApplicationConfig {
    
    let webURL: String
    let apiURL: String
    let noReplyEmail: String
    
    static var environment: ApplicationConfig {
        guard let webURL = Environment.get("WEB_URL"),
            let apiURL = Environment.get("API_URL"),
            let noReplyEmail = Environment.get("NO_REPLY_EMAIL") else {
                fatalError("Please add app configuration to environment variables")
        }
        
        return .init(webURL: webURL, apiURL: apiURL, noReplyEmail: noReplyEmail)
    }
}

extension Application {
    
    struct AppConfigKey: StorageKey {
        typealias Value = ApplicationConfig
    }
    
    var config: ApplicationConfig {
        get {
            storage[AppConfigKey.self] ?? .environment
        }
        set {
            storage[AppConfigKey.self] = newValue
        }
    }
}
