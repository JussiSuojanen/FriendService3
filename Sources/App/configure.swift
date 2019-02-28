import FluentMySQL
import Vapor

/// Called before your application initializes.
public func configure(_ config: inout Config, _ env: inout Environment, _ services: inout Services) throws {
    /// Register providers first
    try services.register(FluentMySQLProvider())

    /// Register routes to the router
    let router = EngineRouter.default()
    try routes(router)
    services.register(router, as: Router.self)

    /// Register middleware
    var middlewares = MiddlewareConfig() // Create _empty_ middleware config
    /// middlewares.use(FileMiddleware.self) // Serves files from `Public/` directory
    middlewares.use(ErrorMiddleware.self) // Catches errors and converts to HTTP response
    services.register(middlewares)

    var databases = DatabasesConfig()
    // Configure a MySQL database
    let databaseConfig = MySQLDatabaseConfig(
        hostname: Environment.get("DB_HOSTNAME")!,
        username: Environment.get("DB_USER")!,
        password: Environment.get("DB_PASSWORD")!,
        database: Environment.get("DB_DATABASE")!
    )
    /// Register the configured MySQL database to the database config.
    let database = MySQLDatabase(config: databaseConfig)
    databases.add(database: database, as: .mysql)
    services.register(database)

    /// Configure migrations
    var migrations = MigrationConfig()
    migrations.add(model: Friend.self, database: .mysql)
    services.register(migrations)
}
