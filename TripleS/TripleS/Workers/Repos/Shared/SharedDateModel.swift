//
//  SharedStringDateModel.swift
//  TripleS
//
//  Created by Andrey Karpenko  on 08.12.2021.
//

import Foundation

struct SharedDateModel: Codable, Equatable {
    private static var dateFormatter: DateFormatter = {
        let formatter: DateFormatter = .init()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        return formatter
    }()
    
    let value: Date
    
    func encode(to encoder: Encoder) throws {
        let string = Self.dateFormatter.string(from: value)
        var container = encoder.singleValueContainer()
        try container.encode(string)
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let string = try container.decode(String.self)
        guard let date = try? string.date()
        else {
            throw DecodingError.dataCorruptedError(
                in: container,
                debugDescription: "Cannot parse data from \(string)"
            )
        }
        self.value = date
    }
    
    init(_ value: Date) {
        self.value = value
    }
}

private extension String {
    func date(
    ) throws -> Date {

        let dateFormatter: DateFormatter = .init()
        
        let formats: [String] = [
            "yyyy-MM-dd'T'HH:mm:ss'Z'",
            "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'",
            "yyyy-MM-dd'T'HH:mm:ss.SSS",
            "yyyy-MM-dd'T'HH:mm:ss",
            "yyyy-MM-dd HH:mm:ss",
            "yyyy-MM-dd HH:mm",
            "yyyy-MM-dd"
        ]

        for format in formats {
            dateFormatter.dateFormat = format
            if let date = dateFormatter.date(from: self) {
                return date
            }
        }

        throw DateFormatterError.cannotParseData
    }
}

private enum DateFormatterError: Error {
    case cannotParseData
}
