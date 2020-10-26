//
//  PashirinHistory.swift
//  pashirin-swiftui
//
//  Created by あっき on 2020/10/22.
//  Copyright © 2020 HONGHYONGGUK. All rights reserved.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseStorage


struct PashirinHistory: View {
    @State private var db: Firestore!
    var body: some View {
    
        ZStack{
            Color(red: 254/255, green: 139/255, blue:93/255).edgesIgnoringSafeArea(.all)
            VStack{
                Image("historypasirin")
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
            let useInfo = db.collection("transactions").whereField("pashiri_id", isEqualTo:userId ?? "PlaceHolderID")
//            let useInfo = db.collection("transactions").whereField("pashiri_id", isEqualTo:この部分に現在ログインしてるユーザーのidが入る！)
            useInfo.getDocuments() {
                (querySnapshot,err) in

                if let err = err {
                    print("Error, \(err)")

                } else {
                print("\(querySnapshot!.documents)")
                    
                    for document in querySnapshot!.documents {
                        
                                   print("This is Pashirin history \(document.data())") //this is get all data from transaction that matches id
                               }
                    }
                
    
            }
        }
    }
}

