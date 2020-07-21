import Vapor
import Fluent

protocol InterestRepository: Repository {
    func filter<Field>(filterBy field: KeyPath<Interest, Field>, value: Field.Value)
        -> EventLoopFuture<[Interest]> where Field: QueryableProperty, Field.Model == Interest
    func filter<Field>(filterBy field: KeyPath<Interest, Field>, values: [Field.Value])
        -> EventLoopFuture<[Interest]> where Field: QueryableProperty, Field.Model == Interest
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
    
    func filter<Field>(filterBy field: KeyPath<Interest, Field>, values: [Field.Value])
    -> EventLoopFuture<[Interest]> where Field: QueryableProperty, Field.Model == Interest {
        return Interest.query(on: database)
            .filter(field ~~ values)
            .all()
    }
    
    func filter<Field>(filterBy field: KeyPath<Interest, Field>, value: Field.Value)
    -> EventLoopFuture<[Interest]> where Field: QueryableProperty, Field.Model == Interest {
        return Interest.query(on: database)
            .filter(field == value)
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
