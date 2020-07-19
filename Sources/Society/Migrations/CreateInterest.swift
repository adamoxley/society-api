import Fluent

struct CreateInterest: Migration {
    
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("interests")
            .id()
            .field("name", .string, .required)
            .field("image", .string, .required)
            .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("interests").delete()
    }
}
