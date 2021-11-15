import Foundation

public protocol AccountAPIProtocol: AnyObject {
    
    func login(
        email: String,
        password: String,
        completion: @escaping (Swift.Result<Void, Swift.Error>) -> Void
    )
    
    func register(
        name: String,
        surname: String,
        email: String,
        password: String,
        completion: @escaping (Swift.Result<Void, Swift.Error>) -> Void
    )
}
