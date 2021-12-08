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
                Text(qrCode ?? "No value")
                    .frame(height: 200, alignment: .center)
            }
            
        }
    }
    
    private func handleScan(result: Result<String, CodeScannerView.ScanError>) {
        showQRCodeReader = false
        switch result {
        case .success(let code):
            qrCode = code
            showLoadingIndicator = false
            print(try? qrCodeProcessor.processQRCode(value: code))
            
        case .failure(let error):
            print("Scanning failed")
        }
    }
}



struct ScannerTabView_Previews: PreviewProvider {
    static var previews: some View {
        ScannerTabView()
    }
}
