//
//  SupplyRepoProtocol.swift
//  TripleS
//
//  Created by Mykhailo Zorin on 05.12.2021.
//

import Foundation


public protocol SupplyAPIProtocol: AnyObject {
    
    func getSupply(
        for id: String,
        completion: @escaping (Swift.Result<SupplyModel, Swift.Error>) -> Void
    )
}


public struct SupplyModel: Codable {
    let id: String
    var product: ProductModel
    let productionDate: Date
    let amount: Double
}

struct ProductModel: Codable {
    let id: String
    let name: String
    let description: String
    let unit: UnitModel
    let shelfLife: TimeInterval
}

struct UnitModel: Codable {
    let id: String
    let name: String
}
