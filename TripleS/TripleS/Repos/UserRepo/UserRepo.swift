import Foundation

public class UserRepo {
    
    enum UserRepoError: Swift.Error {
        case cannotCastToUrl
        case wrongStatusCode
        case noDataInResponse
        case invalidDataInResponse
        case unknownError
    }
    
    // MARK: - Private properties
    
    private let session = URLSession.shared
    
    private let sharedBaseUrl: String = "\(SharedAPIConfiguration.baseUrl)/\(SharedAPIConfiguration.api)/\(SharedAPIConfiguration.user)"
}

// MARK: - Private methods
private extension UserRepo {
    func performGetUserTask(
        for id: String,
        completion: @escaping (Result<UserModel, Error>) -> Void
    ) {
        var urlComponents = URLComponents(string: self.sharedBaseUrl)
        urlComponents?.queryItems = [
            .init(name: "id", value: id)
        ]
        
//        urlComponents?.percentEncodedQuery = urlComponents?.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
        
        guard let url = urlComponents?.url
        else {
            completion(.failure(UserRepoError.cannotCastToUrl))
            return
        }
        
        var request: URLRequest = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task: URLSessionDataTask = self.session.dataTask(
            with: request,
            completionHandler: { [weak self] (data, response, error) in
                
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let response = response as? HTTPURLResponse,
                      (response.statusCode == 200 || response.statusCode == 204)
                else {
                    completion(.failure(UserRepoError.wrongStatusCode))
                    return
                }
                
                guard let data = data
                else {
                    completion(.failure(UserRepoError.noDataInResponse))
                    return
                }
                
                do {
                    let decodedResponse = try jsonDecoder.decode(
                        UserModel.self,
                        from: data
                    )
                    
                    completion(.success(decodedResponse))
                } catch let error {
                    completion(.failure(error))
                    return
                }
            }
        )
        
        task.resume()
    }
    
    func performPutUserTask(
        id: String,
        name: String,
        surname: String,
        nickname: String,
        completion: @escaping (Result<Void, Error>) -> Void
    ) {
        
        let userModel: UserModel = .init(
            id: id,
            name: name,
            surName: surname,
            nickName: nickname,
            roles: nil
        )
        
        guard let url = URL(string: self.sharedBaseUrl)
        else {
            completion(.failure(UserRepoError.cannotCastToUrl))
            return
        }
        
        var request: URLRequest = URLRequest(url: url)
        request.httpMethod = "PUT"
        
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
                    completion(.failure(UserRepoError.wrongStatusCode))
                    return
                }
                
                completion(.success(()))
            }
        )
        
        task.resume()
    }
    
    func performDeleteUserTask(
        for id: String,
        completion: @escaping (Result<Void, Error>) -> Void
    ) {
        var urlComponents = URLComponents(string: self.sharedBaseUrl)
        urlComponents?.queryItems = [
            .init(name: "id", value: id)
        ]
        
//        urlComponents?.percentEncodedQuery = urlComponents?.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
        
        guard let url = urlComponents?.url
        else {
            completion(.failure(UserRepoError.cannotCastToUrl))
            return
        }
        
        var request: URLRequest = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task: URLSessionDataTask = self.session.dataTask(
            with: request,
            completionHandler: { [weak self] (data, response, error) in
                
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let response = response as? HTTPURLResponse,
                      (response.statusCode == 200 || response.statusCode == 204)
                else {
                    completion(.failure(UserRepoError.wrongStatusCode))
                    return
                }
                
                completion(.success(()))
            }
        )
        
        task.resume()
    }
}

// MARK: - UserAPIProtocol
extension UserRepo: UserAPIProtocol {
    public func getUser(
        for id: String,
        completion: @escaping (Result<UserModel, Error>) -> Void
    ) {
        self.performGetUserTask(
            for: id,
            completion: completion
        )
    }
    
    public func putUser(
        id: String,
        name: String,
        surname: String,
        nickname: String,
        completion: @escaping (Result<Void, Error>) -> Void
    ) {
        self.performPutUserTask(
            id: id,
            name: name,
            surname: surname,
            nickname: nickname,
            completion: completion
        )
    }
    
    public func deleteUser(
        for id: String,
        completion: @escaping (Result<Void, Error>) -> Void
    ) {
        self.performDeleteUserTask(
            for: id,
            completion: completion
        )
    }
}
