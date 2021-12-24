//
//  WarehousesWorkerProtocol.swift
//  TripleS
//
//  Created by Andrey Karpenko  on 24.12.2021.
//

import Foundation

public protocol WarehouseAPIProtocol: AnyObject {
    func fetchWarehouses(completion: @escaping (Result<[Warehouse], Error>) -> Void)
    
    func fetchBoxes(
        for warehouseId: String,
        completion: @escaping (Result<[Box], Error>) -> Void
    )
    
    func performUseBox(
        id: String,
        completion: @escaping (Result<Void, Error>) -> Void
    )
    
    func performWriteOff(
        id: String,
        count: Int,
        completion: @escaping (Result<Void, Error>) -> Void
    )
}

public struct Warehouse: Identifiable, Codable {
    public let id: String
    let address: String
    let email: String
}

public struct Box: Identifiable {
    public let id: String
    let warehouseId: String
    let productName: String
    let spoilDate: Date
    var count: Int
    let unit: String
}
