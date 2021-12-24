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
    
    func postSupplyReceive(
        for id: String,
        completion: @escaping (Swift.Result<Void, Swift.Error>) -> Void
    )
}

public struct SupplyModel: Codable, Equatable {
    let id: String
    let supplyCreatedUserId: String
    let acceptUserId: String?
    let dateOrdered: SharedDateModel
    let dateAccepted: SharedDateModel?
    let isArrived: Bool
    let acceptUser: User?
    let supplyCreatedUser: User?
    
    struct User: Codable, Equatable {
        let id: String
        let name: String
        let surName: String
        let nickName: String
    }
}
