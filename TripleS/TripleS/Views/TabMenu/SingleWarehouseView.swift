//
//  SingleWarehouseView.swift
//  TripleS
//
//  Created by Mykhailo Zorin on 23.12.2021.
//

import SwiftUI

struct SingleWarehouseView: View {
    var warehouseId: String
    var body: some View {
        Text(warehouseId)
    }
}

struct SingleWarehouseView_Previews: PreviewProvider {
    static var previews: some View {
        SingleWarehouseView(warehouseId: "1")
    }
}
