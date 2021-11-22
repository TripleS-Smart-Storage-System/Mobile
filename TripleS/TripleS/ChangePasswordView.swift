//
//  ChangePasswordView.swift
//  TripleS
//
//  Created by Mykhailo Zorin on 22.11.2021.
//

import SwiftUI

struct ChangePasswordView: View {
    @State var password1: String = ""
    @State var password2: String = ""
    
    @State var isSecured1 = true
    @State var isSecured2 = true
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(alignment: .center, spacing: 50) {
            PasswordView(isConf: false, isSecured: $isSecured1, password: $password1)
            PasswordView(isConf: true, isSecured: $isSecured2, password: $password2)
            Button("Confirm") {
                changePassword()
            }
            .font(.title)
            .buttonStyle(.bordered)
            Spacer()
        }
        .navigationTitle("Create New Password")
        .padding()
    }
    
    private func changePassword() {
        if password1 == password2 {
            // here show alert
            self.dismiss()
        }
    }
    
}

struct ChangePasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ChangePasswordView()
    }
}
