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
                return NSLocalizedString("You stupid typ goeie enzo", comment: "awo ja typ beter ofzo maat")
        case .errorDecoding:
            return "Response could not be decoded"
        case .unknownError:
            return "Bruhhh!!! I have no idea what go on"
        case .invalidUrl:
            return "HEYYY!!! Give me a valid URL"
        case .serverError(let error):
            return error
        }
    }
}
