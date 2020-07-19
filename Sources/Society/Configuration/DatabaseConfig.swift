import Vapor

struct DatabaseConfig {
    
    static var hostname: String {
        Environment.get("DB_HOSTNAME") ?? "localhost"
    }
    
    static var port: Int {
        guard let portString = Environment.get("DB_PORT"), let portValue = Int(portString) else {
            return 5432
        }
        
        return portValue
    }
    
    static var username: String {
        Environment.get("DB_USERNAME") ?? "username"
    }
    
    static var password: String {
        Environment.get("DB_PASSWORD") ?? "password"
    }
    
    static var database: String {
        Environment.get("DB_NAME") ?? "database"
    }
}
