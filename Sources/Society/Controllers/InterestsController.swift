import Fluent
import Vapor

struct InterestsController: RouteCollection {
    
    func boot(routes: RoutesBuilder) throws {
        let authGroup = routes.grouped(UserToken.authenticator())
        let interestsRoutes = authGroup.grouped("interests")
        interestsRoutes.get("", use: index)
        
    }

    func index(req: Request) throws -> EventLoopFuture<[InterestResponse]> {
        return req.interests
            .all(sortedOn: \.$id)
            .flatMapThrowing { interests in
                interests.map { InterestResponse(from: $0) }
            }
    }
}
