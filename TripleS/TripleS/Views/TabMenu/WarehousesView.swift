//
//  WarehousesView.swift
//  TripleS
//
//  Created by Mykhailo Zorin on 23.12.2021.
//

import SwiftUI

struct WarehousesView: View {
    @State var isLoading: Bool = false
    
    var warehouses: [Warehouse] = testWarehouses
    
    var body: some View {
        if !isLoading {
            List {
                ForEach(warehouses) { warehouse in
                    NavigationLink(warehouse.name, destination: SingleWarehouseView(warehouseId: warehouse.id))
                }
            }
        } else {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle())
                .scaleEffect(4, anchor: .center)
                .frame(height: 200, alignment: .center)
        }
    }
}

struct Warehouse: Identifiable {
    let id: String
    let name: String
}

let testWarehouses = [Warehouse(id: "1", name: "1"), Warehouse(id: "2", name: "2"), Warehouse(id:"3", name: "3")]

struct WarehousesView_Previews: PreviewProvider {
    static var previews: some View {
        WarehousesView()
    }
}
