//
//  ChangeProfileView.swift
//  TripleS
//
//  Created by Mykhailo Zorin on 22.11.2021.
//

import SwiftUI

struct ChangeProfileView: View {
    @Binding var user: User
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(alignment: .leading, spacing: 50) {
            Text("Username: " + user.nickname)
            TextField("First name", text: $user.name)
            TextField("Surname", text: $user.surname)
            HStack {
                Spacer()
                Button("Confirm") {
                    changeInfo()
                }
                .buttonStyle(.bordered)
                Spacer()
            }
            
            Spacer()
        }
        .textFieldStyle(RoundedBorderTextFieldStyle())
        .font(.title)
        .padding()
        .navigationTitle("Change Profile Info")
    }
    
    private func changeInfo(){
        self.dismiss()
    }
}

struct ChangeProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ChangeProfileView(user: .constant(currentUser))
    }
}
