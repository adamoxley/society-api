import Vapor

protocol ApplicationError: AbortError {
    var status: HTTPResponseStatus { get }
    var reason: String { get }
    var headers: HTTPHeaders { get }
    var identifier: String { get }
}
