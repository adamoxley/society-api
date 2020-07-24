import Vapor
import Fluent

protocol Repository {
    func `for`(_ req: Request) -> Self
}

protocol DatabaseRepository: Repository {
    associatedtype DatabaseModel: Model
    
    var database: Database { get }
    
    init(database: Database)
    
    func create(_ model: DatabaseModel) -> EventLoopFuture<Void>
    
    func delete(id: UUID) -> EventLoopFuture<Void>
    
    func filter<Field>(filterBy field: KeyPath<DatabaseModel, Field>, value: Field.Value)
        -> EventLoopFuture<[DatabaseModel]> where Field: QueryableProperty, Field.Model == DatabaseModel
    
    func filter<Field>(filterBy field: KeyPath<Interest, Field>, values: [Field.Value])
        -> EventLoopFuture<[Interest]> where Field: QueryableProperty, Field.Model == Interest
    
    func all<Field>(sortedOn field: KeyPath<DatabaseModel, Field>)
        -> EventLoopFuture<[DatabaseModel]> where Field: QueryableProperty, Field.Model == DatabaseModel
    
    func find(id: UUID?) -> EventLoopFuture<DatabaseModel?>
    
    func update(_ model: DatabaseModel) -> EventLoopFuture<Void>
    
    func set<Field>(_ field: KeyPath<DatabaseModel, Field>,
                    to value: Field.Value,
                    for id: UUID) -> EventLoopFuture<Void> where Field: QueryableProperty, Field.Model == DatabaseModel
    
    func count() -> EventLoopFuture<Int>
}

extension DatabaseRepository {
    func `for`(_ req: Request) -> Self {
        return Self.init(database: req.db)
    }
    
    func create(_ model: DatabaseModel) -> EventLoopFuture<Void> {
        return model.create(on: database)
    }
    
    func delete(id: DatabaseModel.IDValue) -> EventLoopFuture<Void> {
        return DatabaseModel.query(on: database)
            .filter(\._$id == id)
            .delete()
    }
    
    func filter<Field>(filterBy field: KeyPath<DatabaseModel, Field>, value: Field.Value)
        -> EventLoopFuture<[DatabaseModel]> where Field: QueryableProperty, Field.Model == DatabaseModel {
        return DatabaseModel.query(on: database)
            .filter(field == value)
            .all()
    }
    
    func filter<Field>(filterBy field: KeyPath<Interest, Field>, values: [Field.Value])
        -> EventLoopFuture<[Interest]> where Field: QueryableProperty, Field.Model == Interest {
        return Interest.query(on: database)
            .filter(field ~~ values)
            .all()
    }
    
    func all<Field>(sortedOn field: KeyPath<DatabaseModel, Field>)
        -> EventLoopFuture<[DatabaseModel]> where Field: QueryableProperty, Field.Model == DatabaseModel {
        return DatabaseModel.query(on: database)
            .sort(field)
            .all()
    }
    
    func find(id: DatabaseModel.IDValue?) -> EventLoopFuture<DatabaseModel?> {
        return DatabaseModel.find(id, on: database)
    }
    
    func update(_ model: DatabaseModel) -> EventLoopFuture<Void> {
        return model.update(on: database)
    }
    
    func set<Field>(_ field: KeyPath<DatabaseModel, Field>,
                    to value: Field.Value,
                    for id: DatabaseModel.IDValue) -> EventLoopFuture<Void> where Field: QueryableProperty, Field.Model == DatabaseModel {
        return DatabaseModel.query(on: database)
            .filter(\._$id == id)
            .set(field, to: value)
            .update()
    }
    
    func count() -> EventLoopFuture<Int> {
        return DatabaseModel.query(on: database).count()
    }
}
