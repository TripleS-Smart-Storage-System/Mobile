//
//  SupplyWorkerProtocol.swift
//  TripleS
//
//  Created by Mykhailo Zorin on 05.12.2021.
//

import Foundation

public protocol SupplyWorkerProtocol: AnyObject {
    
    var supply: SupplyModel? { get }
    
    func getSupply(
        id: String,
        completion: @escaping (Swift.Result<SupplyModel, Swift.Error>) -> Void
    )
    
}

public protocol SupplyProductWorkerProtocol: AnyObject {
    var supplyProduct: SupplyProductModel? { get }
    
    func getSupplyProduct(
        id: String,
        completion: @escaping (Swift.Result<SupplyProductModel, Swift.Error>) -> Void
    )
}
