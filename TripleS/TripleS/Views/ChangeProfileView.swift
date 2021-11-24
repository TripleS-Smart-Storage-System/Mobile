//
//  ChangeProfileView.swift
//  TripleS
//
//  Created by Mykhailo Zorin on 22.11.2021.
//

import SwiftUI

struct ChangeProfileView: View {
    @State var showAlert: Bool = false
    @State var customAlert: CustomAlert? = nil
    
    @Binding var user: User
    @State var userWithChanges: User
    
    @Environment(\.dismiss) private var dismiss
    
    init(_ user: Binding<User>) {
        self._user = user
        _userWithChanges = State(initialValue: user.wrappedValue)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 50) {
            Text("Username: " + user.nickname)
            TextField("First name", text: $userWithChanges.name)
                .textInputAutocapitalization(.never)
            TextField("Surname", text: $userWithChanges.surname)
                .textInputAutocapitalization(.never)
            HStack {
                Spacer()
                Button("Confirm") {
                    do {
                        customAlert = nil
                        try changeInfo()
                        showAlert = true
                    } catch ProfileChangeError.someEmptyFields {
                        customAlert = CustomAlert(title: "Some Fields Empty", message: "You should fill all fields")
                        showAlert = true
                    } catch ProfileChangeError.nameTooShort {
                        customAlert = CustomAlert(title: "Name is too short", message: "Name should contains 4 or more symbols")
                        showAlert = true
                    } catch ProfileChangeError.surnameTooShort {
                        customAlert = CustomAlert(title: "Surname is too short", message: "Surname should contains 4 or more symbols")
                        showAlert = true
                    } catch {
                        customAlert = CustomAlert(title: "Insufficient Length", message: "Password should contains 8 or more symbols")
                        showAlert = true
                    }
                }
                .buttonStyle(.bordered)
                .alert(isPresented: $showAlert) {
                    guard let alert = customAlert else {
                        return Alert(title: Text("Are you sure you want to change your profile info?"), message: Text("All your previous information will be lost"), primaryButton: .default(Text("Yes")) {
                            user = userWithChanges
                            self.dismiss()
                            // здесь вместо self.dismiss() должна быть отправка запроса на изменение профиля пользователя
                            // в зависимости от этого должно быть действие в 54 - выполнено или нет
                            // тут UI под это дело пока не готов, но можно будет настроить
                        }, secondaryButton: .cancel(){
                            userWithChanges = user
                        })
                    }
                    return Alert(title: Text(alert.title), message: Text(alert.message), dismissButton: .default(Text("Ok")))
                }
                Spacer()
            }
            
            Spacer()
        }
        .textFieldStyle(RoundedBorderTextFieldStyle())
        .font(.title)
        .padding()
        .navigationTitle("Change Profile Info")
    }
    
    private func changeInfo() throws {
        if userWithChanges.name.isEmpty || userWithChanges.surname.isEmpty {
            throw ProfileChangeError.someEmptyFields
        }
        if userWithChanges.name.count < 4 {
            throw ProfileChangeError.nameTooShort
        }
        if userWithChanges.surname.count < 4 {
            throw ProfileChangeError.surnameTooShort
        }
    }
}

struct ChangeProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ChangeProfileView(.constant(currentUser))
    }
}
