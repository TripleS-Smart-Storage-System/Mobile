//
//  QRCodeProcessorProtocol.swift
//  TripleS
//
//  Created by Andrey Karpenko  on 06.12.2021.
//

import Foundation

public protocol QRCodeProcessorProtocol: AnyObject {
    
    func processQRCode(value: String) throws -> QRCodeType
}

public struct SupplyQRCodeModel: Decodable {
    let id: String
}

public struct SupplyProductQRCodeModel: Decodable {
    let id: String
    let date: String
}

public enum QRCodeType {
    case supply(SupplyQRCodeModel)
    case supplyProduct(SupplyProductQRCodeModel)
}
