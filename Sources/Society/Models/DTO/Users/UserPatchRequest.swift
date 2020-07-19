import Vapor

struct UserPatchRequest: Content {
    let name: String?
    let username: String?
    let email: String?
    let dateOfBirth: Date?
}

extension UserPatchRequest: Validatable {
    
    static func validations(_ validations: inout Validations) {
        validations.add("name", as: String.self, is: !.empty)
        validations.add("username", as: String.self, is: !.empty)
        validations.add("email", as: String.self, is: .email)
        validations.add("dateOfBirth", as: Date.self)
    }
}
