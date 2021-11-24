import Foundation

public protocol AccountWorkerProtocol: AnyObject {
    
    // TODO: - Implement RxSwift/Combine if having enough time
    var token: String? { get }
    var profile: UserModel? { get }
    
    func register(
        name: String,
        surname: String,
        email: String,
        password: String,
        completion: @escaping (Swift.Result<Void, Swift.Error>) -> Void
    )
    
    func login(
        email: String,
        password: String,
        completion: @escaping (Swift.Result<Void, Swift.Error>) -> Void
    )
    
    func updateProfile(
        id: String,
        name: String,
        surname: String,
        nickname: String,
        completion: @escaping (Swift.Result<Void, Swift.Error>) -> Void
    )
}
