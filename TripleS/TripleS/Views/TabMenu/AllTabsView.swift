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
                ScannerTabView()
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
                ProfileView(user: accountWorker.profile ?? currentDefaultUser)
            }.tabItem {
                Image(systemName: "person.fill")
                Text("Profile")
            }
            .tag(5)
        }
    }
}

let currentDefaultUser = UserModel(id: "101", name: "Zeratul", surName: "Tassadar", nickName: "zeratul@nure.ua", roles: [RoleModel(id: "1001", name: "Worker"), RoleModel(id:"1002", name: "CEO"), RoleModel(id: "1003", name: "Mentor")])

struct AllTabsView_Previews: PreviewProvider {
    static var previews: some View {
        AllTabsView()
    }
}
