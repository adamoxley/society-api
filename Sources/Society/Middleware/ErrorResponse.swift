import Foundation

struct ErrorResponse: Codable {
    var error: Bool
    var reason: String
    var errorCode: String?
}
