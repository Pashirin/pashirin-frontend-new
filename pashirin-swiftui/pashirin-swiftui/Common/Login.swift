import Foundation

import SwiftUI
import FirebaseAuth
import FirebaseAnalytics
import FirebaseFirestore

struct LoginView: View {
    
    @State private var isSignedIn = false
    @State private var mailAdress = ""
    @State private var password = ""
    @State private var passwordConfirm = ""
    
    @State private var isShowAlert = false
    @State private var isError = false
    @State private var errorMessage = ""
    @State private var isShowSignedOut = false
    
    // Firebase data base obejct
    @State private var db: Firestore!
    // Authefication of use uid (unigue id)
    @State private var userId : String? = nil
    
    @State private var userfirstname  = ""
    @State private var userlastsname  = ""
    
    
    
    var body: some View {
        
        HStack{
            Spacer().frame(width: 50)
            VStack(spacing: 16){
                if self.isSignedIn {
                    Text("Welcome, \(self.userlastsname) \(self.userfirstname) ")
                } else {
                    Text("Start using PASHIRIN")
                }
                
                TextField("Email" , text: $mailAdress).textFieldStyle(RoundedBorderTextFieldStyle())
                SecureField("Password", text: $password).textFieldStyle(RoundedBorderTextFieldStyle())
                SecureField("Confirm password",text: $passwordConfirm ).textFieldStyle(RoundedBorderTextFieldStyle())
            
                
                //login button
                Button(action: {
                    
                    self.errorMessage = ""
                    
                    if self.mailAdress.isEmpty {
                        self.errorMessage = "Email adress is empty"
                        self.isError = true
                        self.isShowAlert = true
                    } else if self.password.isEmpty {
                        self.errorMessage = "Email adress is"
                        self.isError = true
                        self.isShowAlert = true
                        
                    } else if self.passwordConfirm.isEmpty {
                        self.errorMessage = "Confirm password is empty"
                        self.isError = true
                        self.isShowAlert = true
                        
                    } else if self.password.compare(self.passwordConfirm) != .orderedSame {
                        
                        self.errorMessage = "Password dose not match"
                        self.isError = true
                        self.isShowAlert = true
                        
                    } else {
                        
                        
                       logIn()
                    }}) {
                    
                        Text("Login")
                    
                }
                .alert(isPresented: $isShowAlert) {
                    if self.isError {
                        
                        return Alert(title: Text(""), message: Text(self.errorMessage),dismissButton: .destructive(Text("OK")))
                        
                    } else {
                        return Alert(title: Text(""), message: Text("Succeed to Sign up!"), dismissButton: .default(Text("OK")))
                    }
                    
                }
               
                Button(action: {
                    self.logout()
                }){
                    Text("Logout")
                        .foregroundColor(.pink)
                }
                .alert(isPresented: $isShowSignedOut){
                    Alert(title: Text(""), message:Text("LogOut succeed"),dismissButton: .destructive(Text("OK")) )
                    
                }
                Spacer().frame(width: 50)
            }
            .onAppear(){
                self.getCurrentUser()
            }
            
        }
//        .onAppear { // setting for when connect database
//            let settings = FirestoreSettings()
//
//            Firestore.firestore().settings = settings
//            // END setup
//            self.db = Firestore.firestore()
//        }

    }
    
    
    
    private func getCurrentUser() {
          if let _ = Auth.auth().currentUser {
              self.isSignedIn = true
          } else {
              self.isSignedIn = false
          }
      }
    
    
    // logignするための関数
    private func logIn(){
        Auth.auth().signIn(withEmail: self.mailAdress, password: self.password) { authResult, err in
            
            if authResult?.user != nil {
                
                self.isSignedIn = true
                self.isShowAlert = true
                self.isError = false
        
                // get data user uid
//                let userID = authResult?.user.uid
//                let useInfo = db.collection("Users").whereField("user_id", isEqualTo: userID)
//                useInfo.getDocuments() {
//                    (querySnapshot,err) in
//
//                    if let err = err {
//                        print("Error, \(err)")
//
//                    } else {
//
//                        self.userfirstname  = querySnapshot!.documents[0].get("firstname") as! String
//                        self.userlastsname = querySnapshot!.documents[0].get("lastname") as! String
//                    }
//                }
                
            } else {
                
                // login fail
                self.isSignedIn = false
                self.isShowAlert = true
                self.isError = true
//                if let error = error as NSError?,let errorCode = AuthErrors(rawValue)
            }
            
        }
        
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


struct Login_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
