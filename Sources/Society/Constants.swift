struct Constants {
    /// Lifetime of user authentication token: Default 100 days (in seconds)
    static let USER_AUTH_TOKEN_LIFETIME: Double = 60 * 60 * 24 * 100
    
    /// How long should the email tokens live for: Default 24 hours (in seconds)
    static let EMAIL_TOKEN_LIFETIME: Double = 60 * 60 * 24
    
    /// Lifetime of reset password tokens: Default 1 hour (seconds)
    static let RESET_PASSWORD_TOKEN_LIFETIME: Double = 60 * 60
}
