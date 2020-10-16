//
//  PashiriViewModel.swift
//  pashirin-swiftui
//
//  Created by HONGHYONGGUK on 2020/10/16.
//  Copyright © 2020 HONGHYONGGUK. All rights reserved.
//
import Foundation
import FirebaseFirestore

class DataViewModel: ObservableObject {
    @Published var transactionId : String? = nil
    @Published var delivery : Int? = nil
    @Published var name : String? = nil
    @Published var startlocation: String? = nil
    @Published var destination: String? = nil
    @Published var detail: String? = nil
    @Published var price: Int? = nil
    @Published var rating: String? = nil


    
    private var db = Firestore.firestore()
    //これだと全てのトランズアクションを取得してしまう
    func fetchData(){
        db.collection("transactions").document(UserDefaults.standard.string(forKey: "transactionId")as! String).addSnapshotListener {
            documentSnapshot, error in
            guard let document = documentSnapshot else {
                print("No documents")
                
                return
                
            }
            //transactionの
            let data = ((document.data())!)
            let transactionId = UserDefaults.standard.string(forKey: "transactionId")as! String
            let delivery = data["delivery"] as? Int ?? 0
            let name = data["name"] as? String ?? ""
            let startlocation = data["startlocation"] as? String ?? ""
            let destination = data["destination"] as? String ?? ""
            let detail = data["detail"] as? String ?? ""
            let price = data["price"] as? Int ?? 0
            let rating = data["rating"] as? String ?? ""
            print("これが", transactionId)
            
            
//            self.pashiriContact = Contact(transactionId: transactionId, delivery: delivery, startlocation: startlocation, destination: destination, detail: detail, name: name, price: price, rating: rating)
        }
    }
   
    
    
}
