import Vapor

struct UserTokenResponse: Content {
    let value: String
    let expiresAt: Date
    
    init(value: String, expiresAt: Date) {
        self.value = value
        self.expiresAt = expiresAt
    }
    
    init(from userToken: UserToken) {
        self.init(value: userToken.value, expiresAt: userToken.expiresAt)
    }
}
