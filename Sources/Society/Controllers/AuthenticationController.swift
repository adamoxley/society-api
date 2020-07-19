import Vapor
import Fluent

struct AuthenticationController: RouteCollection {
    
    func boot(routes: RoutesBuilder) throws {
        let authRoutes = routes.grouped("auth")
        authRoutes.post("register", use: register)
//
//        let passwordProtected = authRoutes.grouped(User.authenticator())
//        passwordProtected.post("login", use: login)
    }
    
    fileprivate func register(req: Request) throws -> EventLoopFuture<UserTokenAuthenticationResponse> {
        try RegisterRequest.validate(content: req)
        let registerRequest = try req.content.decode(RegisterRequest.self)
        
        guard registerRequest.password == registerRequest.confirmPassword else {
            throw AuthenticationError.passwordMismatch
        }
        
        return req.password.async.hash(registerRequest.password)
            .flatMapThrowing { hash -> User in
                try User(from: registerRequest, hash: hash)
            }.flatMap { user -> EventLoopFuture<User> in
                req.users.create(user).map { user }
            }.flatMapErrorThrowing { error -> User in
                if let dbError = error as? DatabaseError, dbError.isConstraintFailure {
                    throw AuthenticationError.unusableEmail
                }
                throw error
            }.flatMapThrowing { user -> (User, UserToken) in
                try (user, user.generateToken())
            }.flatMap { (user, token) -> EventLoopFuture<(User, UserToken)> in
                req.tokens.create(token).map { (user, token) }
            }.flatMapThrowing { (user, token) -> UserTokenAuthenticationResponse in
                let userResponse = UserResponse(from: user)
                let tokenResponse = UserTokenResponse(from: token)
                return UserTokenAuthenticationResponse(user: userResponse, token: tokenResponse)
            }
    }
}
