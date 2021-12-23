//
//  SingleWarehouseView.swift
//  TripleS
//
//  Created by Mykhailo Zorin on 23.12.2021.
//

import SwiftUI

struct SingleWarehouseView: View {
    @State var isLoading: Bool = false
    
    var boxes: [Box] = testBoxes
    
    let warehouseId: String
    var body: some View {
        if !isLoading {
            List {
                ForEach(boxes) { box in
                    
                    VStack {
                        Text(box.name)
                            .font(.title)
                        Text(box.supplyProduct)
                            .font(.title2)
                    }
                }
            }
        }
        else {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle())
                .scaleEffect(4, anchor: .center)
                .frame(height: 200, alignment: .center)
                .onAppear {
                    // put api for receiving boxes from warehouse with id ((warehouseid)/boxes)
                    supplyWorker.postSupplyProductReceived(for: "", dateOfCreation: Date()) { result in
                        switch result {
                        case .success:
                            //boxes = boxes
                            isLoading = false
                            
                        case .failure(let error):
                            print(error)
                        }
                    }
                }
        }
        
    }
}

struct Box: Identifiable {
    let id: String
    let name: String
    let supplyProduct: String
}

let testBoxes = [Box(id: "1", name: "1", supplyProduct: "1")]

struct SingleWarehouseView_Previews: PreviewProvider {
    static var previews: some View {
        SingleWarehouseView(warehouseId: "1")
    }
}
