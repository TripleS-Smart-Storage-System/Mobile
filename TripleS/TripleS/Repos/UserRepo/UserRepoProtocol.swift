import Foundation

public protocol UserAPIProtocol: AnyObject {
    
    typealias UserToken = String
    
    func getUser(
        for id: String,
        completion: @escaping (Swift.Result<UserModel, Swift.Error>) -> Void
    )
    
    func putUser(
        id: String,
        name: String,
        surname: String,
        nickname: String,
        completion: @escaping (Swift.Result<Void, Swift.Error>) -> Void
    )
    
    func deleteUser(
        for id: String,
        completion: @escaping (Swift.Result<Void, Swift.Error>) -> Void
    )
}

public struct RoleModel: Codable {
    let id: String
    let name: String
}

public struct UserModel: Codable {
    let id: String
    let name: String
    let surName: String
    let nickName: String
    let roles: [RoleModel]?
}
