//
//  URLRequest+setToken.swift
//  TripleS
//
//  Created by Andrey Karpenko  on 06.12.2021.
//

import Foundation

extension URLRequest {
    
    mutating func setToken(_ token: String?) {
        guard let token = token
        else {
            print("\(#function) No token")
            return
        }

        self.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
    }
}
