//
//  SupplyProductRepoProtocol.swift
//  TripleS
//
//  Created by Mykhailo Zorin on 06.12.2021.
//

import Foundation

public protocol SupplyProductAPIProtocol: AnyObject {
    func getSupplyProduct(
        for id: String,
        completion: @escaping (Swift.Result<SupplyProductModel, Swift.Error>) -> Void
    )
    
    func postSupplyProductReceive(
        for id: String,
        productionDate: Date,
        completion: @escaping (Swift.Result<Void, Swift.Error>) -> Void
    )
}

public struct SupplyProductModel: Codable, Equatable {
    let id: String
    let supplyId: String
    let productId: String
    let count: Int
    let isAccepted: Bool
    let productCreatedDate: SharedDateModel
    let product: ProductModel
    
    struct ProductModel: Codable, Equatable {
        let id: String
        let name: String
        let description: String
        let unit: UnitModel
        let shelfLife: String
        
        struct UnitModel: Codable, Equatable {
            let id: String
            let name: String
        }
    }
}
