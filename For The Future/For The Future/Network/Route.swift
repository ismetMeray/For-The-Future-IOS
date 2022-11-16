import Foundation

enum Route {
    case login
    case getAllWorkoutOfUser(Int)
    case getAllExercises
    case getNrOfWorkouts(Int)
    case getExerciseUserData(Int, Int)
    case saveWorkoutRoutine(Int, Int)
    case addExercisesToWorkout(Int, Int)
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
        case .saveWorkoutRoutine(let userId, let workoutId): return "api/workout/\(userId)/user/\(workoutId)/newworkoutroutine"
        case .addExercisesToWorkout(let userId, let workoutId): return "api/workout/\(userId)/user/\(workoutId)/addexercisetoworkoutroutine"

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
        case .getNrOfWorkouts(_): return "nr of workouts of user: "
        case .getExerciseUserData(_, _): return "data of exercise from user"
        case .saveWorkoutRoutine(_,_): return "workout succefully created"
        case .addExercisesToWorkout(_,_): return "exercises added"
        }
    }
}

func url(route: Moya) -> URL {
    return route.baseUrl.appendingPathComponent(route.path)
}
