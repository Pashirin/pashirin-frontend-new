//
//  AccoutDetail.swift
//  pashirin-swiftui
//
//  Created by akina on 2020/10/21.
//  Copyright © 2020 HONGHYONGGUK. All rights reserved.
//


import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseAuth
import FirebaseAnalytics


struct AccountDetail: View {
    //userInfo valriable
    @State private var userId = ""
    @State private var firstname = ""
    @State private var lastname  = ""
    @State private var birth  = ""
    @State private var address  = ""
    //    @State var password = ""
    @State private var isEdit : Bool = false
    //    @State private var showPassword: Bool = false
    
    //email and password related variable
    @State private var email = ""
    @State private var password = ""
    @State private var confirm = ""
    
    //error handling variable
    @State private var isShowEmailUpdateAlert = false
    @State private var isShowPasswordUpdateAlert = false
    @State private var isError = false
    @State private var errorMessage = ""
    
    //View change state variable
    //    @Binding var changePassAndEmail: Bool
    @State private var changePassAndEmail = false
    @State private var isSubmitted = false
    
    //Log out related variable
    @State private var isShowSignedOut = false
    @State private var isSignedIn = true
    
    
    var body: some View {
        ScrollView {
            if changePassAndEmail {
                //            EmailAndPassword(changePassAndEmail: $changePassAndEmail)
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
                                    //                                    self.changePassAndEmail.toggle()
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
                                    self.confirm = ""
                                    //                                    self.changePassAndEmail.toggle()
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
                        withAnimation {
                            self.changePassAndEmail.toggle()
                        }
                    }) {
                        Text("Go Back")
                            .fontWeight(.bold)
                    }
                }
                .transition(.slide)
                .onAppear {
                    self.email = ""
                }
                Spacer().frame(width: 50)
                
            } else {
                //            ScrollView{
                VStack(spacing: 50){
                    Image(systemName: "person") // it is going to be profile photo
                        .font(.system(size: 50))
                        .padding(30)
                        .background(Color.white)
                        .cornerRadius(50)
                    
                    VStack(alignment: .leading, spacing: 20){
                        VStack(alignment: .leading){
                            Text("First name")
                            
                            if (isEdit) {
                                TextField("\(self.firstname)",text: $firstname)
                                    .foregroundColor(Color(red: 139/255, green: 135/255, blue: 135/255))
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .transition(.opacity)
                                
                                
                            } else {
                                Text("\(self.firstname)")
                                    .foregroundColor(Color(red: 139/255, green: 135/255, blue: 135/255))
                                    .transition(.opacity)
                            }
                            
                        }
                        
                        VStack(alignment: .leading){
                            Text("last name")
                            
                            if(isEdit){
                                TextField("\(self.lastname)",text: $lastname)
                                    .foregroundColor(Color(red: 139/255, green: 135/255, blue: 135/255))
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .transition(.opacity)
                            } else {
                                Text("\(self.lastname)")
                                    .foregroundColor(Color(red: 139/255, green: 135/255, blue: 135/255))
                                    .transition(.opacity)
                            }
                        }
                        
                        VStack(alignment: .leading){
                            if isEdit {
                                //                                TextField("\(self.email)", text: $email)
                                //                                    .foregroundColor(Color(red: 139/255, green: 135/255, blue: 135/255))
                                //                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                            } else {
                                Text("Email")
                                Text("\(self.email)")
                                    .foregroundColor(Color(red: 139/255, green: 135/255, blue: 135/255))
                                    .transition(.opacity)
                            }
                        }
                        
                        //                    VStack(alignment: .leading){
                        //                        Text("password")
                        //
                        //                        if (isEdit) {
                        //                            HStack{
                        //                                ZStack(alignment: .trailing){
                        //                                    if (!showPassword){
                        //                                        SecureField("\(self.password)", text: $password)
                        //                                            .foregroundColor(Color(red: 139/255, green: 135/255, blue: 135/255))
                        //                                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        //                                    } else {
                        //                                        TextField("\(self.password)", text: $password)
                        //                                            .foregroundColor(Color(red: 139/255, green: 135/255, blue: 135/255))
                        //                                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        //                                    }
                        //
                        //                                    Button(action: {
                        //                                        self.showPassword.toggle()
                        //                                    }){
                        //                                        if (self.showPassword) {
                        //                                            Image(systemName: "eye.fill")
                        //                                                .font(.system(size: 12))
                        //                                        } else {
                        //                                            Image(systemName: "eye.slash.fill")
                        //                                                .font(.system(size: 12))
                        //                                        }
                        //                                    }
                        //                                }
                        //                            }
                        //                        } else {
                        //                            Text("・・・・・")
                        //                                .foregroundColor(Color(red: 139/255, green: 135/255, blue: 135/255))
                        //                        }
                        //                    }
                        
                        VStack(alignment: .leading){
                            Text("Address")
                            
                            
                            if (isEdit) {
                                TextField("\(self.address)", text: $address)
                                    .foregroundColor(Color(red: 139/255, green: 135/255, blue: 135/255))
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .transition(.opacity)
                            } else {
                                Text("\(self.address)")
                                    .foregroundColor(Color(red: 139/255, green: 135/255, blue: 135/255))
                                    .transition(.opacity)
                                
                            }
                        }
                        
                        
                        VStack(alignment: .leading){
                            Text("Date of Birth")
                            
                            if(isEdit) {
                                TextField("\(self.birth)", text: $birth)
                                    .foregroundColor(Color(red: 139/255, green: 135/255, blue: 135/255))
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .transition(.opacity)
                            } else {
                                Text("\(self.birth)")
                                    .foregroundColor(Color(red: 139/255, green: 135/255, blue: 135/255))
                                    .transition(.opacity)
                            }
                        }
                        
                    }
                    if (!isEdit) {
                        VStack {
                            Button(action: {
                                withAnimation {
                                    self.isEdit = true
                                }
                            }) {
                                Image(systemName: "pencil")
                                Text("Edit")
                                    .fontWeight(.bold)
                            }
                            .padding(15)
                            .background(Color(red: 187/255, green:  187/255, blue:  187/255))
                            .cornerRadius(20)
                            .foregroundColor(Color.white)
                            .frame(width: 200, height: 72)
                            .shadow(color: Color(red: 111/255, green: 111/255, blue: 111/255), radius: 2, x: 0, y: 2)
                            
                            Button(action: {
                                withAnimation {
                                    self.changePassAndEmail.toggle()
                                }
                            }) {
                                Text("Click here to\n change Email and Password")
                                    .fontWeight(.bold)
                            }
                            
                        }
                        
                        
                    } else {
                        HStack {
                            Button(action:{
                                withAnimation {
                                    self.isEdit.toggle()
                                }
                            }){
                                Text("Cancel Edit")
                            }
                            
                            Button(action:{
                                self.submitEditData()
                                self.isSubmitted.toggle()
                            }){
                                Image(systemName:"checkmark")
                                Text("Done")
                            }
                            .alert(isPresented: $isSubmitted) {
                                Alert(title: Text("Success!"), message: Text("User Info has successfully been updated"), dismissButton: .default(Text("OK"), action: {
                                    self.isEdit.toggle()
                                }))
                            }
                        }
                        
                    }
                    
                }
                .transition(.slide)
                .onAppear() {
                    self.getData()
                }
                //            }
            }
        }
        
        
    }
    
    
    func getData()  {
        var db: Firestore!
        // [START setup]
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        // [END setup]
        db = Firestore.firestore()
        // Get current login user uid and email 
        self.userId = Auth.auth().currentUser?.uid ?? "no User ID"
        self.email = Auth.auth().currentUser?.email ?? "No Email found"
        // Get all other information from current user
        var _: Void = db.collection("users").document(self.userId).getDocument() { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data()
                // document.data --> [fistname:"name", lastname : "lastname"] Object with String
                // Cheking type as String
                if let firstname = dataDescription?["firstName"] as? String {
                    self.firstname = firstname
                }
                else {
                    print("This not string.")
                }
                
                if let lastname = dataDescription?["lastName"] as? String {
                    self.lastname = lastname
                }
                else {
                    print("This not string.")
                }
                
                if let birthday = dataDescription?["dateOfBirth"] as? String {
                    self.birth = birthday
                }
                else {
                    print("This not string.")
                }
                
                if let  address = dataDescription?["address"] as? String {
                    self.address = address
                }
                else {
                    print("This not string.")
                }
                
                if let  email = dataDescription?["email"] as? String {
                    self.email = email
                }
                else {
                    print("This not string.")
                }
            } else {
                print("Document does not exist")
            }
        }
    }
    
    
    //編集したデータをデータベースの送る
    func submitEditData()  {
        // データベースの接続？
        // ユーザーのuidにマッチするfiledを取得する
        let db = Firestore.firestore()
        // multiple conditions for setting data
        if self.firstname.isEmpty {
            return
        } else {
            db.collection("users").document(self.userId).setData(["firstName": self.firstname], merge: true)
            print("Updated First Name")
        }
        
        if self.lastname.isEmpty {
            return
        } else {
            db.collection("users").document(self.userId).setData(["lastName": self.lastname], merge: true)
            print("Updated Last Name")
        }
        
        if self.birth.isEmpty {
            return
        } else {
            db.collection("users").document(self.userId).setData(["dateOfBirth": self.birth], merge: true)
            print("Updated Date of Birth")
        }
        
        if self.address.isEmpty {
            return
        } else {
            db.collection("users").document(self.userId).setData(["address": self.address], merge: true)
            print("Updated Address")
        }
        
        // filedの値を更新して
        
    }
    
    private func logout() {
        do {
            try Auth.auth().signOut()
            self.isShowSignedOut = true
            self.isSignedIn = false
            
        } catch let signOutError as NSError {
            
            print("SignOut Error : %@", signOutError)
        }
    }
    
    
}
