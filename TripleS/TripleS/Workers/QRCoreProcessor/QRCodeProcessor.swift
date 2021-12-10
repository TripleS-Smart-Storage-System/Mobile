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
        
        if let supplyProductModel = try? jsonDecoder.decode(
            SupplyProductQRCodeModel.self,
            from: data
        ) {
            return .supplyProduct(supplyProductModel)
        } else if let supplyModel = try? jsonDecoder.decode(
            SupplyQRCodeModel.self,
            from: data
        ) {
            return .supply(supplyModel)
        }
        
        throw QRCodeProcessorError.failedToDecode
    }
}
