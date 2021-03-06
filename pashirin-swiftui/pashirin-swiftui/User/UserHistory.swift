//
//  UserHistory.swift
//  pashirin-swiftui
//
//  Created by あっき on 2020/10/22.
//  Copyright © 2020 HONGHYONGGUK. All rights reserved.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore

struct UserHistory: View {
    @State private var db: Firestore!
//    @State private var date = ""
//    @State private var pashiriName = ""
//    @State private var price = ""
//    @State private var item = ""
    
    var body: some View {
        
        ZStack{
            Color(red: 6/255, green: 91/255, blue:148/255).edgesIgnoringSafeArea(.all)
            VStack{
                Image("history")
                    .offset(y: -230)
                VStack{
                    // show list from history
                }.frame(width:334 , height:180)
            }
        }
        .onAppear(){
            let settings = FirestoreSettings()
            Firestore.firestore().settings = settings
            
            self.db = Firestore.firestore()
            
            let userId = UserDefaults.standard.string(forKey:"current_user_id")
            //transactionsからpashirn_id が一致する全てのデータを持ってくる
            let useInfo = db.collection("transactions").whereField("user_id", isEqualTo:userId ?? "PlaceHolderID")
            //            let useInfo = db.collection("transactions").whereField("pashiri_id", isEqualTo:この部分に現在ログインしてるユーザーのidが入る！)
            useInfo.getDocuments() {
                (querySnapshot,err) in
                
                if let err = err {
                    print("Error, \(err)")
                    
                } else {
                    print("\(querySnapshot!.documents)")
                    
                    for document in querySnapshot!.documents {
//                        let transactionData = document.data()
//                        if let timestamp = transactionData["timestamp"] as? String {
//                            self.date = timestamp
//                        } else {
//                            print("No timestamp")
//                        }
//                        if let pName = transactionData["pashirin_firstName"] as? String {
//                            self.pashiriName = pName
//                        } else {
//                            print("No timestamp")
//                        }
//                        if let p = transactionData["price"] as? String {
//                            self.price = p
//                        } else {
//                            print("No timestamp")
//                        }
//                        if let merch = transactionData["item"] as? String {
//                            self.item = merch
//                        } else {
//                            print("No timestamp")
//                        }
//
//
//
//
//                        VStack(spacing: 20) {
//                            Text(transactionData["pashirin"])
//                        }
                        print("This is Namaken history \(document.data())") //this is get all data from transaction that matches id
                    }
                }
                
                
            }
        }
    }
}

struct UserHistory_Previews: PreviewProvider {
    static var previews: some View {
        UserHistory()
    }
}
