//
//  EmailAndPassword.swift
//  pashirin-swiftui
//
//  Created by Ryu Tamura on 2020/10/25.
//  Copyright © 2020 HONGHYONGGUK. All rights reserved.
//

//
// Not Using this View!!!
//
import SwiftUI
import FirebaseAuth

struct EmailAndPassword: View {
    @State private var email = ""
    @State private var password = ""
    @State private var confirm = ""
    
    @State private var isShowEmailUpdateAlert = false
    @State private var isShowPasswordUpdateAlert = false
    @State private var isError = false
    @State private var errorMessage = ""
    @Binding var changePassAndEmail: Bool
    
    var body: some View {
            Spacer().frame(width: 50)
            VStack {
                Text("Enter new email address")
                TextField("namaken@tadamanjapan.com", text: $email).textFieldStyle(RoundedBorderTextFieldStyle())
                Button(action: {
                    if self.email.isEmpty {
                        self.isShowEmailUpdateAlert = true
                        self.isError = true
                        self.errorMessage = "Please Enter an email address"
                    } else {
                        Auth.auth().currentUser?.updateEmail(to: self.email) { error in
                            self.isShowEmailUpdateAlert = true
                            if let error = error as NSError?, let errorCode = AuthErrorCode(rawValue: error.code) {
                                switch errorCode {
                                case .invalidEmail:
                                    self.errorMessage = "Not a valid email format"
//                                case .requiresRecentLogin:
//                                    self.errorMessage = "Please login"
                                default:
                                    self.errorMessage = error.localizedDescription
                                }
                                self.isError = true
                            } else {
                                self.isError = false
                                self.email = ""
                                self.changePassAndEmail.toggle()
                            }
                        }
                    }
                }) {
                    Text("Change Email Address")
                }
                .alert(isPresented: $isShowEmailUpdateAlert) {
                    if self.isError {
                        return Alert(title: Text(""), message: Text(self.errorMessage), dismissButton: .destructive(Text("OK")))
                    } else {
                        return Alert(title: Text(""), message: Text("Email address has successfully been updated"), dismissButton: .default(Text("OK")))
                    }
                }
                Spacer().frame(height: 50)
                Text("Enter new password")
                SecureField("6 characters or more", text: $password).textFieldStyle(RoundedBorderTextFieldStyle())
                Text("Confirm new password")
                SecureField("6 characters or more", text: $confirm).textFieldStyle(RoundedBorderTextFieldStyle())
                Button(action: {
                    if self.password.isEmpty {
                        self.isShowPasswordUpdateAlert = true
                        self.isError = true
                        self.errorMessage = "Please enter a password"
                    } else if self.confirm.isEmpty {
                        self.isShowPasswordUpdateAlert = true
                        self.isError = true
                        self.errorMessage = "Please confirm password"
                    } else if self.password.compare(self.confirm) != .orderedSame {
                        self.isShowPasswordUpdateAlert = true
                        self.isError = true
                        self.errorMessage = "Password does not match"
                    } else {
                        Auth.auth().currentUser?.updatePassword(to: self.password) { error in
                            self.isShowPasswordUpdateAlert = true
                            if let error = error as NSError?, let errorCode = AuthErrorCode(rawValue: error.code) {
                                switch errorCode {
                                case .weakPassword:
                                    self.errorMessage = "Please enter 6 characters or more"
//                                case .requiresRecentLogin:
//                                    self.errorMessage = "Please log in"
                                default:
                                    self.errorMessage = error.localizedDescription
                                }
                                self.isError = true
                            } else {
                                self.isError = false
                                self.password = ""
                                self.changePassAndEmail.toggle()
                            }
                        }
                    }
                }) {
                    Text("Change Password")
                }
                .alert(isPresented: $isShowPasswordUpdateAlert) {
                    if self.isError {
                        return Alert(title: Text(""), message: Text(self.errorMessage), dismissButton: .destructive(Text("OK")))
                    } else {
                        return Alert(title: Text(""), message: Text("Password has successfully been updated"), dismissButton: .default(Text("OK")))
                    }
                }
                
                Button(action: {
                    self.changePassAndEmail.toggle()
                }) {
                    Text("Go Back")
                        .fontWeight(.bold)
                }
            }
            Spacer().frame(width: 50)
    }

}

//struct EmailAndPassword_Previews: PreviewProvider {
//    static var previews: some View {
//        EmailAndPassword()
//    }
//}
