//
//  AllTabsView.swift
//  TripleS
//
//  Created by Mykhailo Zorin on 02.11.2021.
//

import SwiftUI

struct AllTabsView: View {
    
    @State var selection = 1
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
                Text("Third")
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
                Text("Fifth")
            }.tabItem {
                Image(systemName: "person.fill")
                Text("Profile")
            }
            .tag(5)
        }
    }
}

struct AllTabsView_Previews: PreviewProvider {
    static var previews: some View {
        AllTabsView()
    }
}
