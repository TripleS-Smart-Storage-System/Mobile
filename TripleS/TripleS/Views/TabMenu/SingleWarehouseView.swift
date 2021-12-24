//
//  SingleWarehouseView.swift
//  TripleS
//
//  Created by Mykhailo Zorin on 23.12.2021.
//

import SwiftUI

struct SingleWarehouseView: View {
    private func getDateFormatter() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd / MM / YYYY"
        return formatter
    }
    
    @State var isLoading: Bool = true
    @State var boxes: [Box] = []
    
    let warehouseId: String
    let email: String
    
    var body: some View {
        if !isLoading {
            List {
                ForEach(boxes) { box in
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text(box.productName)
                            .font(.title)
                        Text(String(box.count) + " " + box.unit)
                            .font(.title2)
                        Text(getDateFormatter().string(from: box.spoilDate))
                            .font(.title2)
                    }
                }
            }
            .navigationTitle(email)
        }
        else {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle())
                .scaleEffect(4, anchor: .center)
                .frame(height: 200, alignment: .center)
                .onAppear {
                    // put api for receiving boxes from warehouse with id ((warehouseid)/boxes)
                    WarehouseRepo().fetchBoxes(for: warehouseId) { result in
                        switch result {
                        case .success(let boxes):
                            self.boxes = boxes
                            isLoading = false
                        case .failure(let error):
                            print(error)
                        }
                    }
                }
        }
        
    }
}

let testBoxes = [Box(id: "1", warehouseId: "1", productName: "prodName", spoilDate: Date(), count: 4, unit: "kg")]

struct SingleWarehouseView_Previews: PreviewProvider {
    static var previews: some View {
        SingleWarehouseView(warehouseId: "1", email: "example.com")
    }
}
