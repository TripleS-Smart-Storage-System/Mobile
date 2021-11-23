//
//  ChangePasswordView.swift
//  TripleS
//
//  Created by Mykhailo Zorin on 22.11.2021.
//

import SwiftUI

struct ChangePasswordView: View {
    @State var showAlert: Bool = false
    @State var customAlert: CustomAlert? = nil
    
    @State var password1: String = ""
    @State var password2: String = ""
    
    @State var isSecured1 = true
    @State var isSecured2 = true
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(alignment: .center, spacing: 30) {
            HStack {
                Spacer()
                Button(action: clearAllFields) {
                    Text("Clear")
                        .foregroundColor(.red)
                        .font(.title2)
                }
            }
            Divider()
            PasswordView(isConf: false, isSecured: $isSecured1, password: $password1)
            Divider()
            PasswordView(isConf: true, isSecured: $isSecured2, password: $password2)
            Divider()
            Button("Confirm") {
                do {
                    customAlert = nil
                    try changePassword()
                    showAlert = true
                } catch PasswordChangeError.passwordMismatch {
                    customAlert = CustomAlert(title: "Mismatch", message: "Password mismatch")
                    showAlert = true
                } catch PasswordChangeError.noCapitalLetters {
                    customAlert = CustomAlert(title: "No Capital Letters", message: "You should use capital letters in your password")
                    showAlert = true
                } catch PasswordChangeError.insufficientLength {
                    customAlert = CustomAlert(title: "Insufficient Length", message: "Password should contains 8 or more symbols")
                    showAlert = true
                } catch PasswordChangeError.someEmptyFields {
                    customAlert = CustomAlert(title: "Some Fields Empty", message: "You should fill all fields")
                    showAlert = true
                } catch {
                    customAlert = CustomAlert(title: "Unexpected error", message: "This error is unexpected, write your passwords again")
                    showAlert = true
                }
            }
            .font(.title)
            .buttonStyle(.bordered)
            .alert(isPresented: $showAlert) {
                guard let alert = customAlert else {
                    return Alert(title: Text("Are you sure you want to change password?"), message: Text("Your current password will be lost"), primaryButton: .default(Text("Yes")) {
                        self.dismiss()
                        // здесь вместо self.dismiss() должна быть отправка запроса на изменение пароля
                        // тут UI под это дело пока не готов, но можно будет настроить
                    }, secondaryButton: .cancel(){
                        clearAllFields()
                    })
                }
                return Alert(title: Text(alert.title), message: Text(alert.message), dismissButton: .default(Text("Ok")))
            }
            Spacer()
        }
        .navigationTitle("Create New Password")
        .padding()
    }
    
    private func changePassword() throws {
        if password1.isEmpty || password2.isEmpty {
            throw PasswordChangeError.someEmptyFields
        }
        if password1 != password2 {
            throw PasswordChangeError.passwordMismatch
        }
        if password1.count < 8 {
            throw PasswordChangeError.insufficientLength
        }
        if password1.lowercased() == password1 {
            throw PasswordChangeError.noCapitalLetters
        }
    }
    
    private func clearAllFields() -> Void {
        isSecured1 = true
        isSecured2 = true
        password1 = ""
        password2 = ""
    }
}

struct ChangePasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ChangePasswordView()
    }
}
