//
//  ScannerTabView.swift
//  TripleS
//
//  Created by Mykhailo Zorin on 24.11.2021.
//

import CodeScanner
import SwiftUI

struct ScannerTabView: View {
    @State private var qrCode: String?
    @State private var showQRCodeReader = false
    @State private var showLoadingIndicator = false
//    @State private var qrCodeData: Dataa = testD
    @State private var qrCodeSupplyProductData: SupplyProductModel?
    @State private var qrCodeSupplyData: SupplyModel?
    var body: some View {
        VStack {
            if !showQRCodeReader {
                Button {
                    showQRCodeReader = true
                    showLoadingIndicator = true
                } label: {
                    VStack{
                        Image(systemName: "camera.viewfinder")
                            .font(.system(size: 120))
                            .foregroundColor(.gray)
                        Text("PRESS")
                            .font(.system(size: 30))
                            .foregroundColor(.gray)
                    }
                    .frame(height: 430, alignment: .center)
                }
            } else {
                CodeScannerView(codeTypes: [.qr], simulatedData: "Simulator data",completion: self.handleScan)
                    .frame(height: 430, alignment: .center)
            }
            Divider()
            if showLoadingIndicator {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .scaleEffect(4, anchor: .center)
                    .frame(height: 200, alignment: .center)
            } else {
                if qrCodeSupplyProductData != nil {
                    ShortDescriptionView(qrCodeSupplyProductData: $qrCodeSupplyProductData, qrCodeSupplyData: .constant(nil))
                        .frame(height: 200, alignment: .center)
                } else {
                    if qrCodeSupplyData != nil || qrCodeSupplyProductData != nil {
                        ShortDescriptionView(qrCodeSupplyProductData: $qrCodeSupplyProductData, qrCodeSupplyData: $qrCodeSupplyData)
                            .frame(height: 200, alignment: .center)
                    } else {
                        VStack {
                            Text(qrCode ?? "No Data")
                            if qrCode != nil {
                                Button (action: {
                                    do {
                                        switch try qrCodeProcessor.processQRCode(value: qrCode ?? "") {
                                        case .supplyProduct(let supplyProduct):
                                            supplyWorker.getSupplyProduct(id: supplyProduct.id, completion: { result in
                                                switch result {
                                                    
                                                case .success:
                                                    qrCodeSupplyProductData = supplyWorker.supplyProduct
                                                    qrCodeSupplyData = nil
                                                    
                                                case .failure(let error):
                                                    // TODO: - handle error
                                                    print("\(#function)): \(error)")
                                                }
                                            })
                                        case .supply(let supply):
                                            supplyWorker.getSupply(id: supply.id, completion: {
                                                result in
                                                switch result {
                                                    
                                                case .success:
                                                    qrCodeSupplyProductData = nil
                                                    qrCodeSupplyData = supplyWorker.supply
                                                    
                                                case .failure(let error):
                                                    // TODO: - handle error
                                                    print("\(#function)): \(error)")
                                                }
                                            })
                                                
                                        }
                                    } catch {
                                        debugPrint(error.localizedDescription)
                                    }
                                }) {
                                    Text("Get data")
                                        .font(.title)
                                }
                            }
                        }
                            .frame(height: 200, alignment: .center)
                    }
                }
            }
        }
    }
    
    private func handleScan(result: Result<String, CodeScannerView.ScanError>) {
        showQRCodeReader = false
        
        switch result {
        case .success(let code):
            qrCode = code
            showLoadingIndicator = false
            
            // TODO: - Show details
            print(try? qrCodeProcessor.processQRCode(value: code))
            
        case .failure(let error):
            print("Scanning failed")
        }
    }
}

//let testD = Dataa(id: 1, name: "Rorrrrrrr", desc: "Longds lsdkfk lsdkfl dslf ldksfl dsfkl j sdkdjsjdf jsdfjkjsdkfj kjsdf j sdf sdf sdf kfj ksjf jsdfk jksdf jks sjk jsk jdkfffds", date: Date(), num: 5, unit: "kg", shelfLife: 743.4)

struct ScannerTabView_Previews: PreviewProvider {
    static var previews: some View {
        ScannerTabView()
    }
}
