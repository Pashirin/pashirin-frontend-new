//
//  signUP_RegFormView.swift
//  reg_form
//
//  Created by Ryu Tamura on 2020/10/12.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseAuth

struct RegFormView: View {
    //Declaring states which needs to changed
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var address = ""
    @State private var dateOfBirth = Date()
    @State private var email = ""
    @State private var password = ""
    @State private var passwordConfirm = ""
    @State private var submit = false
    @State private var isShowAlert = false
    @State private var isError = false
    @State private var errorMessage = ""
    @Binding var isSignedUp: Bool
    @Binding var hasAccount: Bool
    @Binding var signedIn: Bool
    
    var body: some View {
            //Each item for registration form
        VStack(spacing: 30){
            Image("holloween")
//            Image("coffee-4")
            VStack(alignment: .leading, spacing: 15){
                TextField("First Name", text: $firstName)
                    .frame(width:300 ,height: 50)
                    .padding(.leading,8)
                    .padding(.trailing,8)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10, style:.continuous))
                    .shadow(color:Color.black.opacity(0.25),  radius: 5, x: 3, y: 3)
                TextField("Last Name", text: $lastName)
                    .frame(width:300 ,height: 50)
                    .padding(.leading,8)
                    .padding(.trailing,8)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10, style:.continuous))
                    .shadow(color:Color.black.opacity(0.25),  radius: 5, x: 3, y: 3)
                TextField("Address", text: $address)
                    .frame(width:300 ,height: 50)
                    .padding(.leading,8)
                    .padding(.trailing,8)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10, style:.continuous))
                    .shadow(color:Color.black.opacity(0.25),  radius: 5, x: 3, y: 3)
                DatePicker("Date of Birth", selection: $dateOfBirth, displayedComponents: .date)
                    .frame(width:300 ,height: 50)
                    .padding(.leading,8)
                    .padding(.trailing,8)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10, style:.continuous))
                    .shadow(color:Color.black.opacity(0.25),  radius: 5, x: 3, y: 3)
                TextField("Email", text: $email)
                    .frame(width:300 ,height: 50)
                    .padding(.leading,8)
                    .padding(.trailing,8)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10, style:.continuous))
                    .shadow(color:Color.black.opacity(0.25),  radius: 5, x: 3, y: 3)
                SecureField("Password", text: $password)
                    .frame(width:300 ,height: 50)
                    .padding(.leading,8)
                    .padding(.trailing,8)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10, style:.continuous))
                    .shadow(color:Color.black.opacity(0.25),  radius: 5, x: 3, y: 3)
                SecureField("Confirm Password", text: $passwordConfirm)
                    .frame(width:300 ,height: 50)
                    .padding(.leading,8)
                    .padding(.trailing,8)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10, style:.continuous))
                    .shadow(color:Color.black.opacity(0.25),  radius: 5, x: 3, y: 3)
            }
           
                
            VStack(spacing: 10){
                Button(action: {
                    //Toggle submit button
                    self.submit.toggle()
                    //Error message handle for each item
                    self.errorMessage = ""
                    if self.firstName.isEmpty {
                        self.errorMessage = "Please enter your first name"
                        self.isError = true
                        self.isShowAlert = true
                    } else if self.lastName.isEmpty {
                        self.errorMessage = "Please enter your last name"
                        self.isError = true
                        self.isShowAlert = true
                    } else if self.address.isEmpty {
                        self.errorMessage = "Please enter your address"
                        self.isError = true
                        self.isShowAlert = true
                    } else if self.email.isEmpty {
                        self.errorMessage = "Please enter your email address"
                        self.isError = true
                        self.isShowAlert = true
                    } else if self.password.isEmpty {
                        self.errorMessage = "Please enter password"
                        self.isError = true
                        self.isShowAlert = true
                    } else if self.passwordConfirm.isEmpty {
                        self.errorMessage = "Please confirm password"
                        self.isError = true
                        self.isShowAlert = true
                    } else if self.password.compare(self.passwordConfirm) != .orderedSame {
                        self.errorMessage = "Password do not match"
                        self.isError = true
                        self.isShowAlert = true
                    //if none matches then execute signUp func
                    } else {
                        
                        self.signUp()
                    }
                })
                {
                    Text("Submit")
                        .font(.system(size: 18))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .frame(width:250 ,height: 50)
                        .padding(.leading,5)
                        .background(Color(red: 254/255, green: 163/255, blue: 93/255))
                        .clipShape(RoundedRectangle(cornerRadius: 15, style:.continuous))
                        .shadow(color:Color.black.opacity(0.25),  radius: 5, x: 3, y: 3)
                        
                }
                .alert(isPresented: $submit){
                    if self.isError {
                        return Alert(title: Text(""), message: Text(self.errorMessage), dismissButton: .destructive(Text("OK")))
                    } else {
                        UserDefaults.standard.set(1, forKey: "requestStatus")
                        return Alert(title: Text("Thanks for Registering!"), dismissButton: Alert.Button.default(Text("OK"), action: { self.signedIn.toggle() }))
                        
                    }
                }
                        
                HStack {
                    Text("Do you have an account?")
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                    Button(action: {
                        withAnimation{
                            self.isSignedUp.toggle()
                            self.hasAccount.toggle()
                        }

                    }){
                        Text("Click here to Login")
                            .font(.system(size: 14))
                    }

                }
            }
                    //Disabling the submit button unless all forms are entered.
    //                .disabled(firstName.isEmpty || lastName.isEmpty || address.isEmpty || email.isEmpty || password.isEmpty || passwordConfirm.isEmpty)
            
        }
    }
    //function for firebase authentication and cloud firestore data input
    private func signUp() {
        //Creating a user with email and password
        Auth.auth().createUser(withEmail: self.email, password: self.password) { authResult, error in
            if let error = error as NSError?, let errorCode = AuthErrorCode(rawValue: error.code) {
                //Email and password error message handling
                switch errorCode {
                case .invalidEmail:
                    self.errorMessage = "Not a valid Email format"
                case .emailAlreadyInUse:
                    self.errorMessage = "This Email address is already in use"
                case .weakPassword:
                    self.errorMessage = "Please enter more than six letters"
                default:
                    self.errorMessage = error.domain
                }
                self.isError = true
                self.isShowAlert = true
            }
            //check whether user was created.
            if let _ = authResult?.user {
                self.isError = false
                self.isShowAlert = true
                //converting timestamp to a string
                let formatter1 = DateFormatter()
                formatter1.dateFormat = "MMM d y"
                let stringDateOfBirth = formatter1.string(from: dateOfBirth)
                //setting firstName into UserDefaults with key "current_user"
                UserDefaults.standard.set(self.firstName, forKey: "current_user")
                //putting userinfo into an array
                let userInfo = [
                    "firstName": self.firstName,
                    "lastName": self.lastName,
                    "dateOfBirth": stringDateOfBirth,
                    "address": self.address
                ] as [String : Any]
                //putting userinfo into cloud firestore
                let docRef = Firestore.firestore().document("users/\(authResult!.user.uid)")
                print("setting userInfo")
                docRef.setData(userInfo) { (error) in
                    if let error = error {
                        print("error = \(error)")
                    } else {
                        print("userInfo uploaded successfully")
                        //clearing form
                        self.firstName = ""
                        self.lastName = ""
                        self.address = ""
                        self.email = ""
                        self.password = ""
                        self.passwordConfirm = ""
                    }
                }
            }
        }
    }
}


