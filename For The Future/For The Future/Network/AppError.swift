import Foundation

enum AppError: Error, LocalizedError, Identifiable{
    case errorDecoding
    case unknownError
    case invalidUrl
    case serverError(String)
    case invalidCredentials
    var id: String{
        self.localizedDescription
    }
    
    var errorDescription: String? {
        switch self {
        case .invalidCredentials:
            return "Login credentials incorrect"
        case .errorDecoding:
            return "Response could not be decoded"
        case .unknownError:
            return "Unknown error, please try again or contact out support team"
        case .invalidUrl:
            return "Invalid url given"
        case .serverError(let error):
            return error
        }
    }
}
