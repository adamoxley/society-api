import Vapor

extension Request {
    var users: UserRepository { application.repositories.users.for(self) }
    var tokens: UserTokenRepository { application.repositories.tokens.for(self) }
    var interests: InterestRepository { application.repositories.interests.for(self) }
}
