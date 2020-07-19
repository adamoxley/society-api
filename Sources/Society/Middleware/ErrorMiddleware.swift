import Vapor

extension ErrorMiddleware {
    
    static func `custom`(environment: Environment) -> ErrorMiddleware {
        return .init { req, error in
            let status: HTTPResponseStatus
            let reason: String
            let headers: HTTPHeaders
            let errorCode: String?
            
            switch error {
            case let applicationError as ApplicationError:
                reason = applicationError.reason
                status = applicationError.status
                headers = applicationError.headers
                errorCode = applicationError.identifier
            case let abortError as AbortError:
                reason = abortError.reason
                status = abortError.status
                headers = abortError.headers
                errorCode = nil
            default:
                // If not caught in the switch, deliever a generic 500 to
                // avoid exposing any sensitive error info
                reason = "Something went wrong."
                status = .internalServerError
                headers = [:]
                errorCode = nil
            }
            
            // Report the error to logger
            req.logger.report(error: error)
            
            // Create a Response with appropriate status
            let response = Response(status: status, headers: headers)
            
            // Attempt to serialize the error to json
            do {
                let errorResponse = ErrorResponse(error: true, reason: reason, errorCode: errorCode)
                response.body = try .init(data: JSONEncoder().encode(errorResponse))
                response.headers.replaceOrAdd(name: .contentType, value: "application/json; charset=utf-8")
            } catch {
                response.body = .init(string: "Oops: \(error)")
                response.headers.replaceOrAdd(name: .contentType, value: "text/plain; charset=utf-8")
            }
            
            return response
        }
    }
}
