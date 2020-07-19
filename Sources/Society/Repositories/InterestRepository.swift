import Vapor
import Fluent

protocol InterestRepository: Repository {
    func all<Field>(sortedOn field: KeyPath<Interest, Field>)
        -> EventLoopFuture<[Interest]> where Field: QueryableProperty, Field.Model == Interest
}

struct DatabaseInterestRepository: InterestRepository, DatabaseRepository {
    let database: Database
    
    func all<Field>(sortedOn field: KeyPath<Interest, Field>)
        -> EventLoopFuture<[Interest]> where Field: QueryableProperty, Field.Model == Interest {
        return Interest.query(on: database)
            .sort(field)
            .all()
    }
}

extension Application.Repositories {
    
    var interests: InterestRepository {
        guard let storage = storage.makeInterestRepository else {
            fatalError("InterestRepository not configured, use: app.interestRepository.use()")
        }
        
        return storage(app)
    }
    
    func use(_ make: @escaping (Application) -> (InterestRepository)) {
        storage.makeInterestRepository = make
    }
}
