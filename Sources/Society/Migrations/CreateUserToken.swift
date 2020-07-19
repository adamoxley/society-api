import Fluent

struct CreateUserToken: Migration {
    
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema(UserToken.schema)
            .id()
            .field("user_id", .uuid, .references("users", "id"))
            .field("value", .string, .required)
            .unique(on: "value")
            .field("created_at", .datetime, .required)
            .field("expires_at", .datetime)
            .create()
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema(UserToken.schema).delete()
    }
}
