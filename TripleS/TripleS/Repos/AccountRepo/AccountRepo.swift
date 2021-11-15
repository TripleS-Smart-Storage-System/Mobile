import Foundation

public class AccountRepo {
    
    enum AccountRepoError: Swift.Error {
        case cannotCastToUrl
        case wrongStatusCode
    }
        
    // MARK: - Private properties
    
    private let session = URLSession.shared
    private let jsonEncoder: JSONEncoder = {
        let encoder: JSONEncoder = .init()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        return encoder
    }()
}

// MARK: - Private methods

private extension AccountRepo {
    
    func performLoginTask(
        email: String,
        password: String,
        completion: @escaping (Result<Void, Error>) -> Void
    ) {
        struct LoginModel: Codable {
            let email: String
            let password: String
        }
        
        guard let url = URL(string: "\(SharedAPIConfiguration.baseUrl)/\(SharedAPIConfiguration.login)")
        else {
            completion(.failure(AccountRepoError.cannotCastToUrl))
            return
        }
        
        let httpBody: LoginModel = .init(
            email: email,
            password: password
        )
        
        var request: URLRequest = URLRequest(url: url)
        request.httpMethod = "POST"
        do {
            request.httpBody = try self.jsonEncoder.encode(httpBody)
        } catch let error {
            completion(.failure(error))
        }
        
        let task: URLSessionDataTask = self.session.dataTask(
            with: request,
            completionHandler: { (data, response, error) in
                
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let response = response as? HTTPURLResponse,
                      response.statusCode == 200
                else {
                    completion(.failure(AccountRepoError.wrongStatusCode))
                    return
                }
                
                completion(.success(()))
            }
        )
        
        task.resume()
    }
    
    func performRegisterTask(
        name: String,
        surname: String,
        email: String,
        password: String,
        completion: @escaping (Result<Void, Error>) -> Void
    ) {
        struct RegisterModel: Codable {
            let name: String
            let surname: String
            let email: String
            let password: String
        }
        
        guard let url = URL(string: "\(SharedAPIConfiguration.baseUrl)/\(SharedAPIConfiguration.register)")
        else {
            completion(.failure(AccountRepoError.cannotCastToUrl))
            return
        }
        
        let httpBody: RegisterModel = .init(
            name: name,
            surname: surname,
            email: email,
            password: password
        )
        
        var request: URLRequest = URLRequest(url: url)
        request.httpMethod = "POST"
        do {
            request.httpBody = try self.jsonEncoder.encode(httpBody)
        } catch let error {
            completion(.failure(error))
        }
        
        let task: URLSessionDataTask = self.session.dataTask(
            with: request,
            completionHandler: { (data, response, error) in
                
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let response = response as? HTTPURLResponse,
                      response.statusCode == 200
                else {
                    completion(.failure(AccountRepoError.wrongStatusCode))
                    return
                }
                
                completion(.success(()))
            }
        )
        
        task.resume()
    }
}

// MARK: - AccountAPIProtocol

extension AccountRepo: AccountAPIProtocol {
    public func login(
        email: String,
        password: String,
        completion: @escaping (Result<Void, Error>) -> Void
    ) {
        
        self.performLoginTask(
            email: email,
            password: password,
            completion: completion
        )
    }
    
    public func register(
        name: String,
        surname: String,
        email: String,
        password: String,
        completion: @escaping (Result<Void, Error>) -> Void
    ) {
        self.performRegisterTask(
            name: name,
            surname: surname,
            email: email,
            password: password,
            completion: completion
        )
    }
}
