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
    
    private var supplyProductData: SupplyProductModel? = nil
    
    private let supplyRepo: SupplyAPIProtocol = SupplyRepo()
    
    private let supplyProductRepo: SupplyProductAPIProtocol = SupplyProductRepo()
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
    
    func fetchSupplyProductData(
        for id: String,
        completion: @escaping (Result<Void, Swift.Error>) -> Void
    ) {
        self.supplyProductRepo.getSupplyProduct(
            for: id,
               completion: { [weak self] (result) in
                   
                   switch result {
                       
                   case .success(let supplyProductData):
                       self?.supplyProductData = supplyProductData
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
    
    func getSupply(id: String, completion: @escaping (Result<SupplyModel, Error>) -> Void) {
        self.supplyRepo.getSupply(for: id, completion: { [weak self] (result) in
            switch result {
            case .success(let supplyData):
                self?.supplyData = supplyData
                completion(.success(supplyData))
            case .failure(let error):
                completion(.failure(error))
            }
            
        })
    }
    
}

// MARK: - SupplyProductWorkerProtocol
extension SupplyWorker: SupplyProductWorkerProtocol {
    
    var supplyProduct: SupplyProductModel? {
        return self.supplyProductData
    }
    
    func getSupplyProduct(id: String, completion: @escaping (Result<SupplyProductModel, Error>) -> Void) {
        self.supplyProductRepo.getSupplyProduct(for: id, completion: { [weak self] (result) in
            switch result {
            case .success(let supplyData):
                self?.supplyProductData = supplyData
                completion(.success(supplyData))
            case .failure(let error):
                completion(.failure(error))
            }
            
        })
    }
    
}
