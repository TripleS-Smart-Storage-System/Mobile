import Foundation

class AccountWorker {
    
    // MARK: - Private properties
    
    private var userToken: String? = nil
    private var userProfile: UserModel? = nil
    
    private let accountRepo: AccountAPIProtocol = AccountRepo()
    private let userRepo: UserAPIProtocol = UserRepo()
}

// MARK: - Private methods
private extension AccountWorker {
    func fetchUserData(
        for id: String,
        completion: @escaping (Result<Void, Swift.Error>) -> Void
    ) {
        self.userRepo.getUser(
            for: id,
            completion: { [weak self] (result) in
            
                switch result {
                    
                case .success(let userModel):
                    self?.userProfile = userModel
                    completion(.success(()))
                    
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        )
    }
}

// MARK: - AccountWorkerProtocol
extension AccountWorker: AccountWorkerProtocol {
    var token: String? {
        return self.userToken
    }
    
    var profile: UserModel? {
        return self.userProfile
    }
    
    func register(
        name: String,
        surname: String,
        email: String,
        password: String,
        completion: @escaping (Result<Void, Error>) -> Void
    ) {
        
        self.accountRepo.register(
            name: name,
            surname: surname,
            email: email,
            password: password,
            completion: completion
        )
    }
    
    func login(
        email: String,
        password: String,
        completion: @escaping (Result<Void, Error>) -> Void
    ) {
        
        self.accountRepo.login(
            email: email,
            password: password,
            completion: { [weak self] (result) in
                
                switch result {
                    
                case .success(let tuple):
                    self?.userToken = tuple.1
                    self?.fetchUserData(
                        for: tuple.0,
                        completion: completion
                    )
                    
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        )
    }
    
    func updateProfile(
        id: String,
        name: String,
        surname: String,
        nickname: String,
        completion: @escaping (Result<Void, Error>) -> Void
    ) {
        
        self.userRepo.putUser(
            id: id,
            name: name,
            surname: surname,
            nickname: nickname,
            completion: { [weak self] (result) in
                
                switch result {
                    
                case .success():
                    self?.fetchUserData(
                        for: id,
                        completion: completion
                    )
                    
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        )
    }
}
