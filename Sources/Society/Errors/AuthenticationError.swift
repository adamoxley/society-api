import Vapor

enum AuthenticationError: ApplicationError {
    case passwordMismatch
    case unusableEmail
    case invalidEmailOrPassword
    case userNotFound
    case emailTokenHasExpired
    case emailTokenNotFound
    case emailIsNotVerified
    case invalidResetPasswordToken
    case resetPasswordTokenHasExpired
}

extension AuthenticationError {
    
    var status: HTTPResponseStatus {
        switch self {
        case .passwordMismatch, .unusableEmail, .emailTokenHasExpired:
            return .badRequest
        case .invalidEmailOrPassword, .emailIsNotVerified, .resetPasswordTokenHasExpired:
            return .unauthorized
        case .userNotFound, .emailTokenNotFound, .invalidResetPasswordToken:
            return .notFound
        }
    }
    
    var reason: String {
        switch self {
        case .passwordMismatch:
            return "Passwords did not match."
        case .unusableEmail:
            return "Unable to use provided email."
        case .invalidEmailOrPassword:
            return "Email or password was incorrect."
        case .userNotFound:
            return "User was not found."
        case .emailTokenNotFound:
            return "Email token not found."
        case .emailTokenHasExpired:
            return "Email token has expired."
        case .emailIsNotVerified:
            return "Email is not verified."
        case .invalidResetPasswordToken:
            return "Invalid reset password token."
        case .resetPasswordTokenHasExpired:
            return "Reset password token has expired."
        }
    }
    
    var identifier: String {
        switch self {
        case .passwordMismatch:
            return "password_mismatch"
        case .unusableEmail:
            return "usable_email"
        case .invalidEmailOrPassword:
            return "invalid_email_or_password"
        case .userNotFound:
            return "user_not_found"
        case .emailTokenNotFound:
            return "email_token_not_found"
        case .emailTokenHasExpired:
            return "email_token_has_expired"
        case .emailIsNotVerified:
            return "email_is_not_verified"
        case .invalidResetPasswordToken:
            return "invalid_password_token"
        case .resetPasswordTokenHasExpired:
            return "password_token_has_expired"
        }
    }
}
