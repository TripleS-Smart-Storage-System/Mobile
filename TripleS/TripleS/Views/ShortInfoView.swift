//
//  ShortDescriptionView.swift
//  TripleS
//
//  Created by Mykhailo Zorin on 08.12.2021.
//

import SwiftUI


struct ShortDescriptionView: View {
    
    private func getDateFormatter() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd / MM / YYYY"
        return formatter
    }
    
    @Binding var qrCode: String?
    @Binding var qrCodeSupplyProductData: SupplyProductModel?
    @Binding var qrCodeSupplyData: SupplyModel?
    
    @State var showSupplyProductDiscardingAlert: Bool = false
    @State var showSupplyDiscardAlert: Bool = false
    @State var showSupplyProductReceivedAlert: Bool = false
    @State var showSupplyReceivedAlert: Bool = false
    
    var body: some View {
        List {
            if qrCodeSupplyProductData != nil {
                VStack(spacing: 30) {
                    Text(qrCodeSupplyProductData!.product.name)
                        .font(.system(size: 30))
                    HStack(alignment: .top,spacing: 15) {
                        VStack(alignment: .leading,spacing: 20) {
                            Text(getDateFormatter().string(from: qrCodeSupplyProductData!.productCreatedDate.value))
                            Text(qrCodeSupplyProductData!.product.shelfLife)
                            Text(String(qrCodeSupplyProductData!.count) + " " + qrCodeSupplyProductData!.product.unit.name)
                        }
                        Divider()
                        ScrollView {
                                Text(qrCodeSupplyProductData!.product.description)
                        }
                    }
                    .font(.system(size: 20))
                }
                .swipeActions(edge: .leading, allowsFullSwipe: true) {
                    Button {
                        supplyWorker.postSupplyProductReceived(
                            for: qrCodeSupplyProductData!.id,
                               dateOfCreation: qrCodeSupplyProductData!.productCreatedDate.value,
                            completion: { result in
                                   
                                switch result {
                                    
                                case .success:
                                    showSupplyProductReceivedAlert = true
                                    
                                case .failure(let error):
                                    print(error)
                                }
                            }
                        )
                        
                    } label: {
                        Image(systemName: "checkmark.circle")
                    }
                    .tint(.green)
                
                }
                .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                    Button {
                        showSupplyProductDiscardingAlert = true
                    } label: {
                        Image(systemName: "x.circle")
                    }
                    .tint(.red)
                }
                .alert("Are you sure you want to discard Supply Product?", isPresented: $showSupplyProductDiscardingAlert) {
                    Button("Yes") {
                        qrCodeSupplyProductData = nil
                        qrCodeSupplyData = nil
                        qrCode = nil
                    }
                    Button("Cancel", role: .cancel){ }
                }
                .alert("Supply product successfully received!", isPresented: $showSupplyProductReceivedAlert) {
                    Button("Okay") {
                        qrCode = nil
                        qrCodeSupplyData = nil
                        qrCodeSupplyProductData = nil
                    }
                }
                .frame(height: 200)
            } else {
                if qrCodeSupplyData != nil {
                    VStack(alignment: .leading, spacing: 25) {
                        Text("Id: " + String(qrCodeSupplyData!.id))
                            .font(.system(size: 25))
                        Text("Created: " + qrCodeSupplyData!.supplyCreatedUser!.name + " " + qrCodeSupplyData!.supplyCreatedUser!.surName )
                            .font(.system(size: 25))
                        Text("Ordered date: " + getDateFormatter().string(from: qrCodeSupplyData!.dateOrdered.value))
                        .font(.system(size: 25))
                    }
                    .swipeActions(edge: .leading, allowsFullSwipe: true) {
                        Button {
                            supplyWorker.postSupplyReceived(
                                for: qrCodeSupplyData!.id,
                                   completion: { result in
                                       
                                       switch result {
                                           
                                       case .success:
                                           showSupplyReceivedAlert = true
                                           
                                       case .failure(let error):
                                           print(error)
                                       }
                                   }
                            )
                        } label: {
                            Image(systemName: "checkmark.circle")
                        }
                        .tint(.green)
                    
                    }
                    .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                        Button {
                            showSupplyDiscardAlert = true
                        } label: {
                            Image(systemName: "x.circle")
                        }
                        .tint(.red)
                    }
                    .alert("Are you sure you want to discard Supply?", isPresented: $showSupplyDiscardAlert) {
                        Button("Yes") {
                            qrCode = nil
                            qrCodeSupplyData = nil
                            qrCodeSupplyProductData = nil
                        }
                        Button("Cancel", role: .cancel){ }
                    }
                    .alert("Supply successfully received!", isPresented: $showSupplyReceivedAlert) {
                        Button("Okay") {
                            qrCode = nil
                            qrCodeSupplyData = nil
                            qrCodeSupplyProductData = nil
                        }
                    }
                    .frame(height: 200)
                } else {
                    Text("Try again")
                }
            }
            
        }
        .listStyle(PlainListStyle())
        
    }
}


extension TimeInterval {
    
    func stringFromTimeInterval() -> String {
        
        let time = NSInteger(self)
        let weeks = (time / 24) / 7
        let days = (time / 24) % 7
        let hours = time % 24
        
        return String(format: "%0.2d w %0.2d d %0.2d h", weeks, days, hours)
    }
}


//struct ShortDescriptionView_Previews: PreviewProvider {
//    static var previews: some View {
//        ShortDescriptionView(qrCodeSupplyProductData: .constant(nil), qrCodeSupplyData: .constant(nil) )
//    }
//}
