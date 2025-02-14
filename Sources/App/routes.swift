import Fluent
import Vapor

func routes(_ app: Application) throws {
    app.get { req async in
        "Doordie works!"
    }

    app.get("hello") { req async -> String in
        "Hello, doordie!"
    }

    try app.register(collection: TodoController())
}
