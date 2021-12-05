//
//  SupplyWorker.swift
//  TripleS
//
//  Created by Mykhailo Zorin on 05.12.2021.
//

import Foundation

class SupplyWorker {
    
    // MARK: - Private properties
    
    //private var userToken: String? = nil
    //private var userProfile: UserModel? = nil
    private var supplyData: SupplyModel? = nil
    
    private let supplyRepo: SupplyAPIProtocol = SupplyRepo()
}

// MARK: - Private methods
private extension SupplyWorker {
    func fetchSupplyData(
        for id: String,
        completion: @escaping (Result<Void, Swift.Error>) -> Void
    ) {
        self.supplyRepo.getSupply(
            for: id,
            completion: { [weak self] (result) in
            
                switch result {
                    
                case .success(let supplyData):
                    self?.supplyData = supplyData
                    completion(.success(()))
                    
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        )
    }
}

// MARK: - SupplyWorkerProtocol
extension SupplyWorker: SupplyWorkerProtocol {
    
    var supply: SupplyModel? {
        return self.supplyData
    }
    
    func getSupply(id: String, completion: @escaping (Result<Void, Error>) -> Void) {
        self.supplyRepo.getSupply(for: id, completion: { [weak self] (result) in
            switch result {
            case .success(let supplyData):
                self?.supplyData = supplyData
            case .failure(let error):
                completion(.failure(error))
            }
            
        })
    }
    func getSupplyProduct(id: String, completion: @escaping (Result<Void, Error>) -> Void) {
        self.supplyRepo.getSupply(for: id, completion: { [weak self] (result) in
            switch result {
            case .success(let supplyData):
                self?.supplyData = supplyData
            case .failure(let error):
                completion(.failure(error))
            }
            
        })
    }
    
//    func login(
//        email: String,
//        password: String,
//        completion: @escaping (Result<Void, Error>) -> Void
//    ) {
//        self.accountRepo.login(
//            email: email,
//            password: password,
//            completion: { [weak self] (result) in
//
//                switch result {
//
//                case .success(let tuple):
//                    self?.userToken = tuple.1
//                    self?.fetchUserData(
//                        for: tuple.0,
//                        completion: completion
//                    )
//
//                case .failure(let error):
//                    completion(.failure(error))
//                }
//            }
//        )
//    }
//
//    func updateProfile(
//        id: String,
//        name: String,
//        surname: String,
//        nickname: String,
//        completion: @escaping (Result<Void, Error>) -> Void
//    ) {
//        self.userRepo.putUser(
//            id: id,
//            name: name,
//            surname: surname,
//            nickname: nickname,
//            completion: { [weak self] (result) in
//
//                switch result {
//
//                case .success():
//                    self?.fetchUserData(
//                        for: id,
//                        completion: completion
//                    )
//
//                case .failure(let error):
//                    completion(.failure(error))
//                }
//            }
//        )
//    }
}

// MARK: - Temporary decision, should have killed it
public let supplyWorker: SupplyWorkerProtocol = SupplyWorker()
