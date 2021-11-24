//
//  ProfileView.swift
//  TripleS
//
//  Created by Mykhailo Zorin on 22.11.2021.
//

import SwiftUI

struct ProfileView: View {
    @State var user: UserModel
    var body: some View {
        VStack {
            Spacer()
            VStack(spacing: 20) {
                HStack {
                    Text("Full name:")
                    Spacer()
                    Text(user.name)
                    Text(user.surName)
                }
                Divider()
                HStack {
                    Text("Email:")
                    Spacer()
                    Text(user.nickName)
                }
                Divider()
                HStack {
                    Text("Roles:")
                    Spacer()
                    VStack(alignment: .trailing,spacing: 5) {
                        ForEach(user.roles ?? [], id: \.id) { role in
                            Text(role.name)
                        }
                    }
                }
            }
            .font(.title)
            Spacer()
            HStack {
                NavigationLink(destination: ChangeProfileView($user)) {
                    Image(systemName: "folder.badge.person.crop")
                        .font(.system(size:35))
                    Text("Change\nInformation")
                }
                Spacer()
                NavigationLink(destination: ChangePasswordView()) {
                    Image(systemName: "lock.shield")
                        .font(.system(size:40))
                    Text("Change\nPassword")
                }
            }
            .buttonStyle(.bordered)
            .font(.title2)
            .frame(height: 250)
        }
        .navigationTitle("Profile")
        .padding()
    }
}
                    
struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(user: currentDefaultUser)
    }
}
