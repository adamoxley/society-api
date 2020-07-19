import Vapor

struct UserAuthenticator: BearerAuthenticator {
    typealias User = Society.User
    
    func authenticate(bearer: BearerAuthorization, for request: Request) -> EventLoopFuture<Void> {
        return request.tokens
            .find(value: bearer.token)
            .unwrap(or: Abort(.forbidden))
            .flatMap { token in
                request.auth.login(token.user)
                return request.eventLoop.makeSucceededFuture(())
            }
    }
}
