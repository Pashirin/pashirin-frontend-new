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
    @State var firstname = "Test"
    @State var lastname  = "Test"
    @State var birth  = "2020/01/01"
    @State var address  = "test"
    @State var email = "test@gmail.com"
    @State var password = "??????"
    @State var isEdit : Bool = false
    @State private var showPassword: Bool = false
    
    
    var body: some View {
        ScrollView{
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
                            
                        
                        } else {
                            Text("\(self.firstname)")
                                .foregroundColor(Color(red: 139/255, green: 135/255, blue: 135/255))
                        }
            
                    }

                    VStack(alignment: .leading){
                        Text("last name")
                        
                        if(isEdit){
                            TextField("\(self.lastname)",text: $lastname)
                                .foregroundColor(Color(red: 139/255, green: 135/255, blue: 135/255))
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                        } else {
                            Text("\(self.lastname)")
                                .foregroundColor(Color(red: 139/255, green: 135/255, blue: 135/255))
                        }
                    }
                    
                    VStack(alignment: .leading){
                        Text("Email")
                            
                        if isEdit {
                                TextField("\(self.email)", text: $email)
                                    .foregroundColor(Color(red: 139/255, green: 135/255, blue: 135/255))
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                        } else {
                            Text("\(self.email)")
                                .foregroundColor(Color(red: 139/255, green: 135/255, blue: 135/255))
                        }
                    }
                    
                    VStack(alignment: .leading){
                        Text("password")
                            
                        if (isEdit) {
                            HStack{
                                ZStack(alignment: .trailing){
                                    if (!showPassword){
                                        SecureField("\(self.password)", text: $password)
                                            .foregroundColor(Color(red: 139/255, green: 135/255, blue: 135/255))
                                            .textFieldStyle(RoundedBorderTextFieldStyle())
                                    } else {
                                        TextField("\(self.password)", text: $password)
                                            .foregroundColor(Color(red: 139/255, green: 135/255, blue: 135/255))
                                            .textFieldStyle(RoundedBorderTextFieldStyle())
                                    }
                                    
                                    Button(action: {
                                        self.showPassword.toggle()
                                    }){
                                        if (self.showPassword) {
                                            Image(systemName: "eye.fill")
                                                .font(.system(size: 12))
                                        } else {
                                            Image(systemName: "eye.slash.fill")
                                                .font(.system(size: 12))
                                        }
                                    }
                                }
                            }
                        } else {
                            Text("・・・・・")
                                .foregroundColor(Color(red: 139/255, green: 135/255, blue: 135/255))
                        }
                    }
                   
                    
                    VStack(alignment: .leading){
                        Text("Address")
                            
                        
                        if (isEdit) {
                            TextField("\(self.address)", text: $address)
                                .foregroundColor(Color(red: 139/255, green: 135/255, blue: 135/255))
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                        } else {
                            Text("\(self.address)")
                                .foregroundColor(Color(red: 139/255, green: 135/255, blue: 135/255))
                
                        }
                    }
                   
                    
                    VStack(alignment: .leading){
                        Text("Date of Birth")
                        
                        if(isEdit) {
                            TextField("\(self.birth)", text: $birth)
                                .foregroundColor(Color(red: 139/255, green: 135/255, blue: 135/255))
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                        } else {
                            Text("\(self.birth)")
                                .foregroundColor(Color(red: 139/255, green: 135/255, blue: 135/255))
                        }
                    }
            
                }
                if (!isEdit) {
                    Button(action: {
                        self.isEdit = true
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
                    

                } else {
                    Button(action:{
                        self.submitEditData()
                    }){
                        Image(systemName:"checkmark")
                        Text("Done")
                    }
                }
                
            }.onAppear() {
                self.getData()
            }
        }
    }
    
    
    
    func  getData()  {
        
        var db: Firestore!
        // [START setup]
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
       // [END setup]
        db = Firestore.firestore()
        
        // Get current login user uid
        var useruid = Auth.auth().currentUser?.uid
        
        
        // Get all information from current user
        var userInfo = db.collection("users").document("isCnkWaRv0RdPpRYlgPwGdwrQyK2").getDocument() { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data()
                // document.data --> [fistname:"name", lastname : "lastname"] Object with String
                
                
                // Cheking type as String
                if let firstname = dataDescription?["firstname"] as? String {
                    self.firstname = firstname
                }
                else {
                    print("This not string.")
                }
                
                if let lastname = dataDescription?["lastname"] as? String {
                    self.lastname = lastname
                }
                else {
                    print("This not string.")
                }
                
                if let birthday = dataDescription?["birthday"] as? String {
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
                
//
                
                
            } else {
                print("Document does not exist")
            }
        }
        
        
//        userInfo.getDocuments() {
//            (querySnapshot,err) in
//                if let err = err {
//                   print("Error, \(err)")
//
//                   } else {
//
//                   }
//               }
        }
    
    
    //編集したデータをデータベースの送る
    func submitEditData()  {
        // データベースの接続？
        // ユーザーのuidにマッチするfiledを取得する
        
        var user = Auth.auth().currentUser;
        // filedの値を更新して
        isEdit = false
    }

}
