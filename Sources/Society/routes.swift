import Fluent
import Vapor

func routes(_ app: Application) throws {
    
    // MARK: - API Group
    app.group("api") { api in
        // Authentication
        try! api.register(collection: AuthenticationController())
        
        // User
        try! api.register(collection: UserController())
        
        // Interests
        try! api.register(collection: InterestsController())
    }
}
