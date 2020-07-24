import Vapor
import Fluent

protocol UserRepository {
    func find(email: String) -> EventLoopFuture<User?>
    func exists(username: String) -> EventLoopFuture<Bool>
}

struct DatabaseUserRepository: UserRepository, DatabaseRepository {
    typealias DatabaseModel = User
    
    let database: Database
    
    func find(email: String) -> EventLoopFuture<User?> {
        return User.query(on: database)
            .filter(\.$email == email)
            .first()
    }
    
    func exists(username: String) -> EventLoopFuture<Bool> {
        User.query(on: database)
            .filter(\.$username == username)
            .first()
            .map { $0 != nil }
    }
}

extension Application.Repositories {
    
    var users: DatabaseUserRepository {
        guard let storage = storage.makeUserRepository else {
            fatalError("DatabaseUserRepository not configured, use: app.userRepository.use()")
        }
        
        return storage(app)
    }
    
    func use(_ make: @escaping (Application) -> (DatabaseUserRepository)) {
        storage.makeUserRepository = make
    }
}
