import Foundation

public protocol AccountAPIProtocol: AnyObject {
    
    typealias UserToken = String
    
    func login(
        email: String,
        password: String,
        completion: @escaping (Swift.Result<UserToken, Swift.Error>) -> Void
    )
    
    func register(
        name: String,
        surname: String,
        email: String,
        password: String,
        completion: @escaping (Swift.Result<UserToken, Swift.Error>) -> Void
    )
}
