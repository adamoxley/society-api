import Vapor

struct UserTokenAuthenticationResponse: Content {
    let user: UserResponse
    let token: UserTokenResponse
    
    init(user: UserResponse, token: UserTokenResponse) {
        self.user = user
        self.token = token
    }
}
