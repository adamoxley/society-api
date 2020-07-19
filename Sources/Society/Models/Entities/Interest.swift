import Fluent
import Vapor

final class Interest: Model, Content {
    static let schema = "interests"
    
    @ID(key: .id)
    var id: UUID?

    @Field(key: "name")
    var name: String
    
    @Field(key: "image")
    var image: String

    init() {}

    init(id: UUID? = nil, name: String, image: String) {
        self.id = id
        self.name = name
        self.image = image
    }
}
