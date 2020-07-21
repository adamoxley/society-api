import Foundation
import Vapor

func migrations(_ app: Application) throws {
    app.migrations.add(CreateUser())
    app.migrations.add(CreateUserToken())
    app.migrations.add(CreateInterest())
    app.migrations.add(CreateUserInterestPivot())
}
