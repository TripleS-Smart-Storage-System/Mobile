//
//  Product.swift
//  TripleS
//
//  Created by Mykhailo Zorin on 04.11.2021.
//

import Foundation

struct Supply:Identifiable {
    let id: UUID
    let product: Product
    let productionDate: Date
    let amount: Double
}

struct Product {
    let name: String
    let description: String
    let unit: Unit
    let shelfLife: TimeInterval // TODO create specific dt
}


enum Unit: String {
    case kg
    case ml
    case pc
}
