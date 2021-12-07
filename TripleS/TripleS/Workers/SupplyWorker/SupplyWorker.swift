//
//  SupplyWorker.swift
//  TripleS
//
//  Created by Mykhailo Zorin on 05.12.2021.
//

import Foundation

class SupplyWorker {
    
    // MARK: - Private properties
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
}
