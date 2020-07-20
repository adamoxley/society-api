import Fluent

struct CreateUserInterestPivot: Migration {
    
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema(UserInterestPivot.schema)
            .id()
            .field("user_id", .uuid, .references("users", "id"))
            .field("interest_id", .uuid, .references("interests", "id"))
            .unique(on: "user_id", "interest_id")
            .create()
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema(UserInterestPivot.schema).delete()
    }
}
