//
//  LoginView.swift
//  TripleS
//
//  Created by Mykhailo Zorin on 02.11.2021.
//

import SwiftUI

struct LoginView: View {
    @Binding var willMoveToNextScreen: Bool

    @State var FirstName: String = ""
    @State var LastName: String = ""
    @State var Email: String = ""
    
    @State var Password: String = ""
    @State var PasswordConf: String = ""
    
    @State var isSecuredFirst: Bool = true
    @State var isSecuredSecond: Bool = true
    
    @State var isError: Bool = false
    @State var isRegistration: Bool = false
    
    @State var alert = CustomAlert(title: "", message: "")
    @State private var showingAlert = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 40) {
                if isRegistration {
                    TextField("First name", text: $FirstName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .textInputAutocapitalization(.never)
                        .font(.title)
                    TextField("Last name", text: $LastName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .textInputAutocapitalization(.never)
                        .font(.title)
                }
                TextField("Email", text: $Email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .textInputAutocapitalization(.never)
                    .keyboardType(.emailAddress)
                    .font(.title)
                PasswordView(isConf: false, isSecured: $isSecuredFirst, password: $Password)
                if isRegistration {
                    PasswordView(isConf: true, isSecured: $isSecuredSecond, password: $PasswordConf)
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
                            changeLoginView()
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
                        .alert("Registration complete", isPresented: $showingAlert) {
                            Button("OK") {
                                changeLoginView()
                            }
                        }
                        Spacer()
                        Button(action:{
                            changeLoginView()
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
        let email = Email
        let pass = Password
        
//        if email.isEmpty || pass.isEmpty {
//            throw LoginError.incompleteForm
//        }
//        if pass.count < 8 {
//            throw LoginError.incorrectPasswordLength
//        }
//        if email.uppercased() != email.lowercased() {
//            throw LoginError.invalidUsername
//        }
        
        accountWorker.login(
            email: email,
            password: Password,
            completion: {(result) in
                
                switch result {
                    
                case .success():
                    willMoveToNextScreen = true
                    
                case .failure(let error):
                    // TODO: - handle error
                    print("\(#function)): \(error)")
                }
            }
        )
//        if email == "1111" && pass.count == 8 { // check existance of user
//            willMoveToNextScreen = true
//        }
    }
        
    func registration() throws {
        let email = Email
        let pass = Password
        let pass2 = PasswordConf
        
//        if email.isEmpty || pass.isEmpty || pass2.isEmpty {
//            throw LoginError.incompleteForm
//        }
//        if pass.count < 8 && pass2.count < 8 {
//            throw LoginError.incorrectPasswordLength
//        }
//        if email.uppercased() != email.lowercased() {
//            throw LoginError.invalidUsername
//        }
//        if pass != pass2 {
//            throw LoginError.mismatchedPasswords
//        }
        
        accountWorker.register(
            name: FirstName,
            surname: LastName,
            email: email,
            password: pass,
            completion: {(result) in
                
                switch result {
                    
                case .success():
                    showingAlert = true
                    
                case .failure(let error):
                    // TODO: - handle error
                    print("\(#function): \(error)")
                }
            }
        )
//        if email == "1111" && pass.count == 8 { // check existance of userA*I
//            // adding user to db
//        }

    }
    
    private func changeLoginView() {
        isRegistration.toggle()
        FirstName = ""
        LastName = ""
        Email = ""
        Password = ""
        PasswordConf = ""
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(willMoveToNextScreen: .constant(false))
    }
}
