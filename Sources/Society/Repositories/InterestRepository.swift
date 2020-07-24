import Vapor
import Fluent

protocol InterestRepository: Repository {}

struct DatabaseInterestRepository: InterestRepository, DatabaseRepository {
    typealias DatabaseModel = Interest
    
    let database: Database
}

extension Application.Repositories {
    
    var interests: DatabaseInterestRepository {
        guard let storage = storage.makeInterestRepository else {
            fatalError("DatabaseInterestRepository not configured, use: app.interestRepository.use()")
        }
        
        return storage(app)
    }
    
    func use(_ make: @escaping (Application) -> (DatabaseInterestRepository)) {
        storage.makeInterestRepository = make
    }
}
