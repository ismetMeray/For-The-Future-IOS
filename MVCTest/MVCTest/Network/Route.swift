//import Foundation
//
//enum Route {
//    static let baseUrl = "https://yummie.glitch.me"
//
//    case fetchAllCategories
//    case placeOrder(String)
//    case fetchCategoryDishes(String)
//    case fetchOrders
//
//    var description: String {
//        switch self {
//        case .fetchAllCategories:
//            return "/dishes/cat1"
//        case .placeOrder(let dishId):
//            return "/orders/\(dishId)"
//        case .fetchCategoryDishes(let categoryId):
//            return "/dishes/\(categoryId)"
//        case .fetchOrders:
//            return "/orders"
//        }
//    }
//}


import Foundation

enum Route {
    case login
    case getAllWorkoutOfUser(Int)
    case getAllExercises
    case getNrOfWorkouts(Int)
    case getExerciseUserData(Int, Int)
}

protocol Moya: Path {
    var baseUrl: URL {get}
    var sampleData: String {get}
}

protocol Path {
    var path : String { get }
}

extension Route : Path {
    
    var path: String {
        switch self {
        case .login: return "api/auth/login"
        case .getAllWorkoutOfUser (let userId): return "api/workout/\(userId)/user"
        case .getAllExercises: return "api/exercise/"
        case .getNrOfWorkouts(let userId): return "api/workout/\(userId)/nrofworkouts"
        case .getExerciseUserData(let userId, let exerciseId): return "api/exercise/\(userId)/user/\(exerciseId)/exercisedata"

        }
    }
}

extension Route : Moya {
    var baseUrl: URL {return URL(string: "http://localhost:5000/")!}

    var sampleData: String {
        switch self {
        case .login: return "login"
        case .getAllWorkoutOfUser (let userId): return "workouts of \(userId)"
        case .getAllExercises: return "all Exercises"
        case .getNrOfWorkouts(let userId): return "nr of workouts of user: "
        case .getExerciseUserData(let userId, let exerciseId): return "data of exercise from user"
        }
    }
}

func url(route: Moya) -> URL {
    return route.baseUrl.appendingPathComponent(route.path)
}
