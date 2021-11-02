//
//  ContentView.swift
//  TripleS
//
//  Created by Mykhailo Zorin on 02.11.2021.
//

import SwiftUI

struct ContentView: View {
    @State var selection = 1
    @State var loginDone = false
    
    var body: some View {
        if !loginDone {
            LoginView(willMoveToNextScreen: $loginDone)
        } else {
            AllTabsView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
