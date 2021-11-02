//
//  PasswordView.swift
//  TripleS
//
//  Created by Mykhailo Zorin on 02.11.2021.
//

import SwiftUI

struct PasswordView: View {
    let isConf: Bool
    @Binding var isSecured: Bool
    @Binding var password: String
    var body: some View {
        ZStack(alignment: .trailing) {
            if isSecured {
                SecureField(isConf ? "Confirm pass" : "Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .font(.title)
            } else {
                TextField(isConf ? "Confirm pass" : "Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .font(.title)
            }
            Button(action: {
                isSecured.toggle()
            }, label: {
                Image(systemName: isSecured ? "eye.slash": "eye")
            })
        }
    }
}

struct PasswordView_Previews: PreviewProvider {
    static var previews: some View {
        PasswordView(isConf: false, isSecured: .constant(false), password: .constant(""))
    }
}
