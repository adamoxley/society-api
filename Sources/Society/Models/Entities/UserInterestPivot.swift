import Vapor
import Fluent

final class UserInterestPivot: Model {
    static let schema = "user_interest_pivot"
    
    @ID(key: .id)
    var id: UUID?
    
    @Parent(key: "user_id")
    var user: User
    
    @Parent(key: "interest_id")
    var interest: Interest
    
    init() { }
    
    init(id: UUID? = nil, user: User, interest: Interest) throws {
        self.id = id
        self.$user.id = try user.requireID()
        self.$interest.id = try interest.requireID()
    }
}
