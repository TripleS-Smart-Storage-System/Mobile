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
                    NavigationLink {
                        SingleWarehouseView(warehouseId: warehouse.id) // here you can pass data for next view
                    } label: {
                        VStack {
                            Text(warehouse.address)
                                .font(.title)
                            Text(warehouse.email)
                                .font(.title2)
                        }
                    }
                }
            }
        } else {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle())
                .scaleEffect(4, anchor: .center)
                .frame(height: 200, alignment: .center)
                .onAppear {
                    // put api for receiving warehouses here
                    supplyWorker.postSupplyProductReceived(for: "", dateOfCreation: Date()) { result in
                        switch result {
                        case .success:
                            //warehouses = warehouses
                            isLoading = false
                            
                        case .failure(let error):
                            print(error)
                        }
                    }
                }
        }
    }
}

let testWarehouses = [Warehouse(id: "1", address: "1", email: "1"), Warehouse(id: "2", address: "2", email: "2"), Warehouse(id: "3", address: "3", email: "3")]

struct WarehousesView_Previews: PreviewProvider {
    static var previews: some View {
        WarehousesView()
    }
}
