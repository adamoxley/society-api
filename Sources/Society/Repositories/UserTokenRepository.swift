import Vapor
import Fluent

protocol UserTokenRepository: Repository {
    func create(_ token: UserToken) -> EventLoopFuture<Void>
    func delete(value: String) -> EventLoopFuture<Void>
    func find(value: String) -> EventLoopFuture<UserToken?>
}

struct DatabaseUserTokenRepository: UserTokenRepository, DatabaseRepository {
    let database: Database
    
    func create(_ token: UserToken) -> EventLoopFuture<Void> {
        return token.create(on: database)
    }
    
    func delete(value: String) -> EventLoopFuture<Void> {
        return UserToken.query(on: database)
            .filter(\.$value == value)
            .delete()
    }
    
    func find(value: String) -> EventLoopFuture<UserToken?> {
        return UserToken.query(on: database)
            .filter(\.$value == value)
            .first()
    }
}

extension Application.Repositories {
    
    var tokens: UserTokenRepository {
        guard let storage = storage.makeUserTokenRepository else {
            fatalError("UserTokenRepository not configured, use: app.userTokenRepository.use()")
        }
        
        return storage(app)
    }
    
    func use(_ make: @escaping (Application) -> (UserTokenRepository)) {
        storage.makeUserTokenRepository = make
    }
}
