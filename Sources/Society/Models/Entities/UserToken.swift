import Vapor
import Fluent

final class UserToken: Model {
    
    static let schema = "user_tokens"
    
    @ID(key: "id")
    var id: UUID?
    
    @Parent(key: "user_id")
    var user: User
    
    @Field(key: "value")
    var value: String
    
    @Field(key: "expires_at")
    var expiresAt: Date
    
    @Timestamp(key: "created_at", on: .create)
    var createdAt: Date?
    
    init() {}
    
    init(id: UUID? = nil, value: String, userId: User.IDValue, expiresAt: Date) {
        self.id = id
        self.$user.id = userId
        self.value = value
        self.expiresAt = expiresAt
    }
}

extension UserToken: ModelTokenAuthenticatable {
    
    static let valueKey = \UserToken.$value
    static let userKey = \UserToken.$user
    
    var isValid: Bool {
        return expiresAt > Date()
    }
}
