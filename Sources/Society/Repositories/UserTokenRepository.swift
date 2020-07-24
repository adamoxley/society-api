import Vapor
import Fluent

protocol UserTokenRepository: Repository {
    func delete(value: String) -> EventLoopFuture<Void>
    func find(value: String) -> EventLoopFuture<UserToken?>
}

struct DatabaseUserTokenRepository: UserTokenRepository, DatabaseRepository {
    typealias DatabaseModel = UserToken
    
    let database: Database
    
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
    
    var tokens: DatabaseUserTokenRepository {
        guard let storage = storage.makeUserTokenRepository else {
            fatalError("DatabaseUserTokenRepository not configured, use: app.userTokenRepository.use()")
        }
        
        return storage(app)
    }
    
    func use(_ make: @escaping (Application) -> (DatabaseUserTokenRepository)) {
        storage.makeUserTokenRepository = make
    }
}
