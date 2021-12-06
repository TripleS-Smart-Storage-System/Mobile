//
//  QRCodeProcessor.swift
//  TripleS
//
//  Created by Andrey Karpenko  on 06.12.2021.
//

import Foundation

class QRCodeProcessor {
    enum QRCodeProcessorError: Error {
        case failedToConvertToData
        case failedToDecode
    }
}

// MARK: - QRCodeProcessorProtocol
extension QRCodeProcessor: QRCodeProcessorProtocol {
    func processQRCode(value: String) throws -> QRCodeType {
        
        guard let data = value.data(using: .utf8)
        else {
            throw QRCodeProcessorError.failedToConvertToData
        }
        
        if let supplyModel = try? jsonDecoder.decode(
            SupplyQRCodeModel.self,
            from: data
        ) {
            return .supply(supplyModel)
        } else if let productModel = try? jsonDecoder.decode(
            ProductQRCodeModel.self,
            from: data
        ) {
            return .product(productModel)
        }
        
        throw QRCodeProcessorError.failedToDecode
    }
}
