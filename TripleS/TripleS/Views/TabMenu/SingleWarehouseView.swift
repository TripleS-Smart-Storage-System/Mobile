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
    @State var boxes: [Box] = testBoxes
    
    @State var isLoadingUseBox: Bool = false
    @State var isLoadingWriteOff: Bool = false
    
    @State var boxRequiredId: String = ""
    
    let warehouseId: String
    let email: String
    
    private func updateUI() {
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
    
    var body: some View {
        if !isLoading {
            List {
                ForEach(boxes) { box in
                    HStack(spacing: 20) {
                        Button("Use") {
                            WarehouseRepo().performWriteOff(id: box.id, count: 1) { result in
                                switch result {
                                case .success:
                                    updateUI()
                                case .failure:
                                    print("error")
                                }
                            }
                        }
                        .tint(.green)
                        VStack(alignment: .leading, spacing: 10) {
                            Text(box.productName)
                                .font(.title)
                            Text(String(box.count) + " " + box.unit)
                                .font(.title2)
                            Text(getDateFormatter().string(from: box.spoilDate))
                                .font(.title2)
                        }
                        Spacer()
                        Button("Write off") {
                            WarehouseRepo().performUseBox(id: box.id) { result in
                                switch result {
                                case .success:
                                    updateUI()
                                case .failure:
                                    print("error")
                                }
                            }
                        }
                        .tint(.red)
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
