//
//  LoginView.swift
//  TripleS
//
//  Created by Mykhailo Zorin on 02.11.2021.
//

import SwiftUI

struct LoginView: View {
    @Binding var willMoveToNextScreen: Bool
    
    @State var username: String = ""
    @State var password: String = ""
    @State var passwordConf: String = ""
    
    @State var isSecuredFirst: Bool = true
    @State var isSecuredSecond: Bool = true
    
    @State var isError: Bool = false
    @State var isRegistration: Bool = false
    
    @State var alert = CustomAlert(title: "", message: "")
    
    var body: some View {
        NavigationView {
            VStack(spacing: 40) {
                TextField("Username", text: $username)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .font(.title)
                PasswordView(isConf: false, isSecured: $isSecuredFirst, password: $password)
                if isRegistration {
                    PasswordView(isConf: true, isSecured: $isSecuredSecond, password: $passwordConf)
                }
                HStack {
                    if !isRegistration {
                        Spacer()
                        Button(action: {
                            do {
                                try login()
                            } catch LoginError.incompleteForm{
                                debugPrint("Incomplete form")
                                alert = CustomAlert(title: "Incomplete form", message: "Please fill both fields")
                                self.isError = true
                            } catch LoginError.incorrectPasswordLength {
                                debugPrint("Incorrect password length")
                                alert = CustomAlert(title: "Password too short", message: "Password should be at least 8 characters")
                                self.isError = true
                            } catch LoginError.invalidUsername {
                                debugPrint("Invalid username")
                                alert = CustomAlert(title: "Invalid username format", message: "Use letters of the same register")
                                self.isError = true
                            } catch {
                                debugPrint(error.localizedDescription)
                            }
                        }) {
                            Text("Login")
                                .font(.title)
                        }
                        .alert(isPresented: $isError) {
                            Alert(title: Text(alert.title),
                                  message: Text(alert.message),
                                  dismissButton: .default(Text("Ok")))
                        }
                        Spacer()
                        Button(action: {
                            isRegistration = true
                        }) {
                            Text("Registration")
                                .font(.title)
                        }
                        Spacer()
                    } else {
                        Spacer()
                        Button (action: {
                            do {
                                try registration()
                            } catch {
                                debugPrint(error.localizedDescription)
                            }
                        }) {
                            Text("Sign in")
                                .font(.title)
                        }
                        Spacer()
                        Button(action:{
                            isRegistration = false
                        }) {
                            Text("Back")
                                .font(.title)
                        }
                        Spacer()
                    }
                }
            }
            .padding()
            .navigationBarTitle("TripleS")
        }
    }
    
    func login() throws {
        let name = username
        let pass = password
        
        if name.isEmpty || pass.isEmpty {
            throw LoginError.incompleteForm
        }
        if pass.count < 8 {
            throw LoginError.incorrectPasswordLength
        }
        if name.uppercased() != name.lowercased() {
            throw LoginError.invalidUsername
        }
        
        if name == "1111" && pass.count == 8 { // check existance of user
            willMoveToNextScreen = true
        }
    }
        
    func registration() throws {
        let name = username
        let pass = password
        let pass2 = passwordConf
        
        if name.isEmpty || pass.isEmpty || pass2.isEmpty {
            throw LoginError.incompleteForm
        }
        if pass.count < 8 && pass2.count < 8 {
            throw LoginError.incorrectPasswordLength
        }
        if name.uppercased() != name.lowercased() {
            throw LoginError.invalidUsername
        }
        if pass != pass2 {
            throw LoginError.mismatchedPasswords
        }
        if name == "1111" && pass.count == 8 { // check existance of userA*I
            // adding user to db
            willMoveToNextScreen = true
        }

    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(willMoveToNextScreen: .constant(false))
    }
}
