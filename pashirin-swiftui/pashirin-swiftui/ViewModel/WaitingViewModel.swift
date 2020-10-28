//
//  WaitingViewModel.swift
//  pashirin-swiftui
//
//  Created by HONGHYONGGUK on 2020/10/14.
//  Copyright © 2020 HONGHYONGGUK. All rights reserved.
//

import Foundation
import Firebase
import FirebaseFirestore

class WaitingViewModel: ObservableObject{
    @Published var status: Int?=0
    private var db = Firestore.firestore()
    init(){
        print("This is the WaitingViewModel and the statusCode is \(String(describing: status)) now")
        fetchStatusFromFB()
    }
    
    func fetchStatusFromFB(){
        let transactionId = UserDefaults.standard.value(forKey: "transactionId")
        print("ここは", transactionId)
        //ここで止まる
        
        db.collection("transactions").document(transactionId as!String).addSnapshotListener { documentSnapshot, error in
            guard let document = documentSnapshot else {
                print("No documents")
                
                return
            }
            self.status = ((document.data()!["status"])! as!Int)
            print("WaitingViewModel line31の self.statusは：", self.status ?? 0)
            
            
            //            let h = document.metadata.hasPendingWrites ? "Local" : "Server"
            //            UserDefaults.standard.set(self.status, forKey: "requestStatus")
            //            print("in WaitingViewModel, requestStatus is ", UserDefaults.standard.value(forKey: "requestStatus")!)
            
        }
    }
    func fetchTransactionStatus() -> Int {
        let transactionId = UserDefaults.standard.string(forKey: "transactionId")
        if transactionId != nil{
            db.collection("transactions").document(transactionId ?? "").getDocument{ (snapshot, error) in
                if let data = snapshot?.data() {
                    print(data["status"] ?? 0)
                } else {
                    print("Couldn't find the document")
                }
            }
            return 0
        }
        return 0
    }
}


