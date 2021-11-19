import Foundation

public class AccountRepo {
    
    enum AccountRepoError: Swift.Error {
        case cannotCastToUrl
        case wrongStatusCode
        case noDataInResponse
        case invalidDataInResponse
        case unknownError
    }
    
    // MARK: - Private properties
    
    private let session = URLSession.shared
    
    private let sharedBaseUrl: String = "\(SharedAPIConfiguration.baseUrl)/\(SharedAPIConfiguration.api)/\(SharedAPIConfiguration.account)"
}

// MARK: - Private methods

private extension AccountRepo {
    
    func performLoginTask(
        email: String,
        password: String,
        completion: @escaping (Result<String, Error>) -> Void
    ) {
        struct LoginModel: Codable {
            let email: String
            let password: String
        }
        
        guard let url = URL(string: "\(self.sharedBaseUrl)/\(SharedAPIConfiguration.login)")
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
            request.httpBody = try jsonEncoder.encode(httpBody)
        } catch let error {
            completion(.failure(error))
        }
        
        let task: URLSessionDataTask = self.session.dataTask(
            with: request,
            completionHandler: { [weak self] (data, response, error) in
                
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
                
                do {
                    let decodedResponse = try self?.handleAuthResponse(for: data)
                    
                    guard let decodedResponse = decodedResponse
                    else {
                        completion(.failure(AccountRepoError.unknownError))
                        return
                    }
                    
                    completion(.success(decodedResponse.token))
                } catch let error {
                    completion(.failure(error))
                    return
                }
            }
        )
        
        task.resume()
    }
    
    func performRegisterTask(
        name: String,
        surname: String,
        email: String,
        password: String,
        completion: @escaping (Result<String, Error>) -> Void
    ) {
        struct RegisterModel: Codable {
            let name: String
            let surname: String
            let email: String
            let password: String
        }
        
        guard let url = URL(string: "\(self.sharedBaseUrl)/\(SharedAPIConfiguration.register)")
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
            request.httpBody = try jsonEncoder.encode(httpBody)
        } catch let error {
            completion(.failure(error))
        }
        
        let task: URLSessionDataTask = self.session.dataTask(
            with: request,
            completionHandler: { [weak self] (data, response, error) in
                
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
                
                do {
                    let decodedResponse = try self?.handleAuthResponse(for: data)
                    
                    guard let decodedResponse = decodedResponse
                    else {
                        completion(.failure(AccountRepoError.unknownError))
                        return
                    }
                    
                    completion(.success(decodedResponse.token))
                } catch let error {
                    completion(.failure(error))
                    return
                }
            }
        )
        
        task.resume()
    }
    
    struct ResponseModel: Decodable {
        let id: String
        let email: String
        let token: String
    }
    
    func handleAuthResponse(
        for data: Data?
    ) throws -> ResponseModel {
        
        guard let data = data
        else {
            throw AccountRepoError.noDataInResponse
        }
        
        let response: ResponseModel
        do {
            response = try jsonDecoder.decode(
                ResponseModel.self,
                from: data
            )
        } catch let error {
            print(error)
            throw AccountRepoError.invalidDataInResponse
        }
        
        return response
    }
}

// MARK: - AccountAPIProtocol

extension AccountRepo: AccountAPIProtocol {
    
    public func login(
        email: String,
        password: String,
        completion: @escaping (Result<UserToken, Error>) -> Void
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
        completion: @escaping (Result<UserToken, Error>) -> Void
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
