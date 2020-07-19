import Fluent

struct CreateUser: Migration {
    
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("users")
            .id()
            .field("email", .string, .required)
            .field("password_hash", .string, .required)
            .field("name", .string, .required)
            .field("username", .string)
            .field("date_of_birth", .date)
            .field("is_admin", .bool, .required, .custom("DEFAULT FALSE"))
            .field("is_email_verified", .bool, .required, .custom("DEFAULT FALSE"))
            .field("created_at", .datetime, .required)
            .field("updated_at", .datetime, .required)
            .unique(on: "email")
            .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("users").delete()
    }
}
