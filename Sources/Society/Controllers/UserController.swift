import Fluent
import Vapor

struct UserController: RouteCollection {
    
    func boot(routes: RoutesBuilder) throws {
        let usersRoutes = routes.grouped("users")
        usersRoutes.get("", use: index)
        usersRoutes.get(":id", use: retrieveID)
        
        let userProtectedRoutes = usersRoutes.grouped(UserToken.authenticator())
        userProtectedRoutes.get("me", use: retrieve)
        userProtectedRoutes.delete("me", use: delete)
        userProtectedRoutes.patch("me", use: update)
    }

    fileprivate func index(req: Request) throws -> EventLoopFuture<[UserResponse]> {
        return req.users
            .all(sortedOn: \.$createdAt)
            .flatMapThrowing { users in
                users.map { UserResponse(from: $0) }
            }
    }
    
    fileprivate func retrieveID(req: Request) throws -> EventLoopFuture<UserResponse> {
        let userID = try req.parameters.require("id", as: User.IDValue.self)
        return try retrieveUser(req, userID: userID)
    }
    
    fileprivate func retrieve(req: Request) throws -> EventLoopFuture<UserResponse> {
        let user = try req.auth.require(User.self)
        guard let userID = try? user.requireID() else { throw Abort(.badRequest) }
        return try retrieveUser(req, userID: userID)
    }
    
    fileprivate func update(req: Request) throws -> EventLoopFuture<UserResponse> {
        let user = try req.auth.require(User.self)
        let userPatchRequest = try req.content.decode(UserPatchRequest.self)
        
        guard let userID = try? user.requireID() else { throw Abort(.badRequest) }
        
        return req.users
            .find(id: userID)
            .unwrap(or: Abort(.notFound))
            .flatMap { user in
                if let name = userPatchRequest.name { user.name = name }
                if let username = userPatchRequest.username { user.username = username }
                if let email = userPatchRequest.email { user.email = email }
                if let dateOfBirth = userPatchRequest.dateOfBirth { user.dateOfBirth = dateOfBirth }
                
                return req.users
                    .update(user)
                    .flatMapThrowing {
                        UserResponse(from: user)
                    }
            }
    }

    fileprivate func delete(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        let user = try req.auth.require(User.self)
        guard let userID = try? user.requireID() else { throw Abort(.badRequest) }
        
        return req.users
            .delete(id: userID)
            .map { .gone }
    }
    
    fileprivate func retrieveUser(_ req: Request, userID: User.IDValue) throws -> EventLoopFuture<UserResponse> {
        return req.users
            .find(id: userID)
            .unwrap(or: Abort(.forbidden))
            .flatMapThrowing { user in
                UserResponse(from: user)
            }
    }
}
