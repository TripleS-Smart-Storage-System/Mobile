//
//  User.swift
//  TripleS
//
//  Created by Mykhailo Zorin on 22.11.2021.
//

import Foundation

struct User: Identifiable {
    let id: String
    var name: String
    var surname: String
    let nickname: String
    let roles: [Role]
}

struct Role: Identifiable {
    let id: String
    let role: String
}
