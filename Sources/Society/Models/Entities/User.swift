import Fluent
import Vapor

final class User: Model {
    
    static let schema = "users"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "name")
    var name: String
    
    @Field(key: "username")
    var username: String?
    
    @Field(key: "email")
    var email: String
    
    @Field(key: "password_hash")
    var passwordHash: String
    
    @Field(key: "is_admin")
    var isAdmin: Bool
    
    @Timestamp(key: "created_at", on: .create)
    var createdAt: Date?
    
    @Timestamp(key: "updated_at", on: .update)
    var updatedAt: Date?
    
    @Field(key: "is_email_verified")
    var isEmailVerified: Bool
    
    @Field(key: "date_of_birth")
    var dateOfBirth: Date?

    init() {}

    init(id: UUID? = nil, name: String, username: String? = nil, email: String, passwordHash: String,
         isAdmin: Bool = false, isEmailVerified: Bool = false, dateOfBirth: Date? = nil) {
        self.id = id
        self.name = name
        self.username = username
        self.email = email
        self.passwordHash = passwordHash
        self.isAdmin = isAdmin
        self.isEmailVerified = isEmailVerified
        self.dateOfBirth = dateOfBirth
    }
}

// MARK: - RegisterRequest

extension User {

    convenience init(from register: RegisterRequest, hash: String) throws {
        self.init(name: register.name, email: register.email, passwordHash: hash)
    }
}

// MARK: - UserToken

extension User {
    
    func generateToken() throws -> UserToken {
        let expiresAt = Date().addingTimeInterval(Constants.USER_AUTH_TOKEN_LIFETIME)
        let token = SHA256.hash(string: [UInt8].random(count: 16).base64)
        
        return try UserToken(value: token,
                      userId: self.requireID(),
                      expiresAt: expiresAt)
    }
}

// MARK: - ModelAuthenticatable

extension User: ModelAuthenticatable {
    
    static let usernameKey = \User.$email
    static let passwordHashKey = \User.$passwordHash
    
    func verify(password: String) throws -> Bool {
        try Bcrypt.verify(password, created: self.passwordHash)
    }
}
