import Crypto
import Foundation

extension SHA256 {
    
    static func hash(string: String) -> String {
        SHA256.hash(data: string.data(using: .utf8)!).hex
    }
}
