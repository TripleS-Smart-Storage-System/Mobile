//
//  AllTabsView.swift
//  TripleS
//
//  Created by Mykhailo Zorin on 02.11.2021.
//

import SwiftUI

struct AllTabsView: View {
    
    @State var selection = 1
    @State var isAnimating = true
    
    @State private var qrCode: String?
    @State private var showQRCodeReader = false
    
    var body: some View {
        TabView(selection: $selection) {
            // 1
            NavigationView {
                WarehouseView()
            }.tabItem {
                Image(systemName: "house")
                Text("Warehouse")
            }
            .tag(1)
            
            // 2
            NavigationView {
                Text("Second")
            }.tabItem {
                Image(systemName: "timer")
                Text("Expire date")
            }
            .tag(2)
            
            // 3
            NavigationView {
                VStack {
                    Text(qrCode ?? "Empty string")
                    Button("Read QR code") {
                        self.showQRCodeReader = true
                    }
                }
                .fullScreenCover(isPresented: $showQRCodeReader) {
                    BarcodeReaderVC(qrCode: $qrCode)
                }
            }.tabItem {
                Image(systemName: "qrcode.viewfinder")
                Text("QR code")
            }
            .tag(3)
            
            // 4
            NavigationView {
                Text("Forth")
            }.tabItem {
                Image(systemName: "list.bullet.rectangle.portrait")
                Text("Catalog")
            }
            .tag(4)
            
            // 5
            NavigationView {
                ProfileView(user: currentUser)
            }.tabItem {
                Image(systemName: "person.fill")
                Text("Profile")
            }
            .tag(5)
        }
    }
}

let currentUser = User(id: "101", name: "Zeratul", surname: "Tassadar", nickname: "zeratul@nure.ua", roles: [Role(id: "1001", role: "Worker"), Role(id:"1002", role: "CEO"), Role(id: "1003", role: "Mentor")])

struct AllTabsView_Previews: PreviewProvider {
    static var previews: some View {
        AllTabsView()
    }
}