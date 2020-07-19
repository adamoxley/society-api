import Vapor
import Fluent

protocol Repository {
    func `for`(_ req: Request) -> Self
}

protocol DatabaseRepository: Repository {
    var database: Database { get }
    init(database: Database)
}

extension DatabaseRepository {
    func `for`(_ req: Request) -> Self {
        return Self.init(database: req.db)
    }
}

extension Application {
    
    struct Repositories {
        struct Provider {
            static var database: Self {
                .init {
                    $0.repositories.use { DatabaseUserRepository(database: $0.db) }
                    $0.repositories.use { DatabaseUserTokenRepository(database: $0.db) }
                    $0.repositories.use { DatabaseInterestRepository(database: $0.db) }
                }
            }
            
            let run: (Application) -> ()
        }
        
        final class Storage {
            var makeUserRepository: ((Application) -> UserRepository)?
            var makeUserTokenRepository: ((Application) -> UserTokenRepository)?
            var makeInterestRepository: ((Application) -> InterestRepository)?
            init() { }
        }
        
        struct Key: StorageKey {
            typealias Value = Storage
        }
        
        let app: Application
        
        func use(_ provider: Provider) {
            provider.run(app)
        }
        
        var storage: Storage {
            if app.storage[Key.self] == nil {
                app.storage[Key.self] = .init()
            }
            
            return app.storage[Key.self]!
        }
    }
    
    var repositories: Repositories {
        .init(app: self)
    }
}
