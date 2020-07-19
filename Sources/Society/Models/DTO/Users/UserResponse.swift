import Vapor

struct UserResponse: Content {
    let id: UUID?
    let name: String
    let email: String
    let isAdmin: Bool
    
    init(id: UUID? = nil, name: String, email: String, isAdmin: Bool) {
        self.id = id
        self.name = name
        self.email = email
        self.isAdmin = isAdmin
    }
    
    init(from user: User) {
        self.init(id: user.id, name: user.name, email: user.email, isAdmin: user.isAdmin)
    }
}
