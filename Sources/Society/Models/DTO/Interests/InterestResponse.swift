import Vapor

struct InterestResponse: Content {
    let id: UUID?
    let name: String
    let image: String
    
    init(id: UUID? = nil, name: String, image: String) {
        self.id = id
        self.name = name
        self.image = image
    }
    
    init(from interest: Interest) {
        self.init(id: interest.id, name: interest.name, image: interest.image)
    }
}
