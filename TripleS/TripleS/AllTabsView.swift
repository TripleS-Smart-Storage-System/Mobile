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
    
    @State private var image: Image?
    @State private var showingImagePicker = false
    
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
                PageControl(numberOfPages: 4, currentPage: $selection)
            }.tabItem {
                Image(systemName: "timer")
                Text("Expire date")
            }
            .tag(2)
            
            // 3
            NavigationView {
                ActivityIndicator(isAnimating: $isAnimating)
            }.tabItem {
                Image(systemName: "qrcode.viewfinder")
                Text("QR code")
            }
            .tag(3)
            
            // 4
            NavigationView {
                VStack {
                    image?.resizable()
                        .scaledToFit()
                    Button("Select Image") {
                        self.showingImagePicker = true
                    }
                }
                .sheet(isPresented: $showingImagePicker) {
                    PageViewController()
                }
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
