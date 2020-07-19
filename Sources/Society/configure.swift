import Vapor
import Fluent
import FluentPostgresDriver

public func configure(_ app: Application) throws {
            
    #if DEBUG
    print(app.directory.workingDirectory)
    print(app.directory.publicDirectory)
    print(app.directory.resourcesDirectory)
    print(app.directory.viewsDirectory)
    #endif
    
    // MARK: - Encoding & Decoding
    let encoder = JSONEncoder()
    encoder.dateEncodingStrategy = .deferredToDate
    encoder.keyEncodingStrategy = .convertToSnakeCase
    
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    
    // Override the global encoder used for the `.json` media type
    ContentConfiguration.global.use(encoder: encoder, for: .json)
    ContentConfiguration.global.use(decoder: decoder, for: .json)
        
    // MARK: - Database
    let databaseConfig = PostgresConfiguration(
        hostname: DatabaseConfig.hostname,
        port: DatabaseConfig.port,
        username: DatabaseConfig.username,
        password: DatabaseConfig.password,
        database: DatabaseConfig.database
    )

    // Register the configured database to the databases config.
    app.databases.use(.postgres(configuration: databaseConfig), as: .psql)
    
    // MARK: - Middleware
    app.middleware = .init()
    app.middleware.use(ErrorMiddleware.custom(environment: app.environment))
    
    // MARK: - App Config
    app.config = .environment
        
    try routes(app)
    try migrations(app)
    try services(app)
    
    if app.environment == .development {
        try app.autoMigrate().wait()
    }
}
