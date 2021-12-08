//
//  ShortDescriptionView.swift
//  TripleS
//
//  Created by Mykhailo Zorin on 08.12.2021.
//

import SwiftUI

//struct Dataa {
//    let id: Int
//    let name: String
//    let desc: String
//    let date: Date
//    let num: Double
//    let unit: String
//    let shelfLife: TimeInterval
//}

struct ShortDescriptionView: View {
    
    private func getDateFormatter() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd / MM / YYYY"
        return formatter
    }
    
    @Binding var qrCodeSupplyProductData: SupplyProductModel?
    @Binding var qrCodeSupplyData: SupplyModel?
    
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
                        print("1")
                    } label: {
                        Image(systemName: "checkmark.circle")
                    }
                    .tint(.green)
                
                }
                .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                    Button {
                        print("2")
                    } label: {
                        Image(systemName: "x.circle")
                    }
                    .tint(.red)
                }
                .frame(height: 200)
            } else {
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
                        print("3")
                    } label: {
                        Image(systemName: "checkmark.circle")
                    }
                    .tint(.green)
                
                }
                .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                    Button {
                        print("4")
                    } label: {
                        Image(systemName: "x.circle")
                    }
                    .tint(.red)
                }
                .frame(height: 200)
            }
            
        }
        .listStyle(PlainListStyle())
        
    }
}


extension TimeInterval{
    
    func stringFromTimeInterval() -> String {
        
        let time = NSInteger(self)
        let weaks = (time / 24) / 7
        let days = (time / 24) % 7
        let hours = time % 24
        
        return String(format: "%0.2d w %0.2d d %0.2d h",weaks, days, hours)
    }
}


//struct ShortDescriptionView_Previews: PreviewProvider {
//    static var previews: some View {
//        ShortDescriptionView(qrCodeSupplyProductData: .constant(nil), qrCodeSupplyData: .constant(nil) )
//    }
//}
