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
    
    var body: some View {
        VStack {
            Text(qrCode ?? "Empty string")
            Button("Read QR code") {
                self.showQRCodeReader = true
            }
        }
        .sheet(isPresented: $showQRCodeReader) {
            CodeScannerView(codeTypes: [.qr], simulatedData: "Michael\nZorin\nmz@nure.ua",completion: self.handleScan)
        }
    }
    
    func handleScan(result: Result<String, CodeScannerView.ScanError>) {
        self.showQRCodeReader = false
        switch result {
        case .success(let code):
            qrCode = code
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
