
public protocol RolesRepoProtocol: AnyObject {
    
    func getRoles(
        completion: @escaping (Swift.Result<Void, Swift.Error>) -> Void
    )
    
    func getRole(
        for name: String,
        completion: @escaping (Swift.Result<Void, Swift.Error>) -> Void
    )
}
