//
//  ProfileView.swift
//  TripleS
//
//  Created by Mykhailo Zorin on 22.11.2021.
//

import SwiftUI

struct ProfileView: View {
    @State var user: User
    var body: some View {
        VStack {
            Spacer()
            VStack(spacing: 20) {
                HStack {
                    Text("Full name:")
                    Spacer()
                    Text(user.name)
                    Text(user.surname)
                }
                Divider()
                HStack {
                    Text("Email:")
                    Spacer()
                    Text(user.nickname)
                }
                Divider()
                HStack {
                    Text("Roles:")
                    Spacer()
                    VStack(alignment: .trailing,spacing: 5) {
                        ForEach(user.roles, id: \.id) { role in
                            Text(role.role)
                        }
                    }
                }
            }
            .font(.title)
            Spacer()
            HStack {
                Spacer()
                NavigationLink(destination: ChangeProfileView(user: $user)) {
                    Image(systemName: "folder.badge.person.crop")
                    Text("Change Info")
                }
                Spacer()
                NavigationLink(destination: ChangePasswordView()) {
                    Image(systemName: "lock.shield")
                    Text("Set Password")
                }
                Spacer()
            }
            .buttonStyle(.bordered)
            .font(.title3)
            .frame(height: 250)
        }
        .navigationTitle("Profile")
        .padding()
    }
}
                    
struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(user: currentUser)
    }
}
