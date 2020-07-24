import Vapor

extension Request {
    var users: DatabaseUserRepository { application.repositories.users.for(self) }
    var tokens: DatabaseUserTokenRepository { application.repositories.tokens.for(self) }
    var interests: DatabaseInterestRepository { application.repositories.interests.for(self) }
}
