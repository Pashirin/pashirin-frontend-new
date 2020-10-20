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
    //@Published var transactionId : String? = nil
    @Published var delivery : Int? = nil
    @Published var name : String? = nil
    @Published var startlocation: String? = nil
    @Published var destination: String? = nil
    @Published var detail: String? = nil
    @Published var price: Int? = nil
    @Published var rating: String? = nil
    
    init(){
        fetchData()
    }

    
    private var db = Firestore.firestore()
    //これだと全てのトランズアクションを取得してしまう
    func fetchData(){
        
        print("これがpashiriからの変更ステータス4  ", UserDefaults.standard.string(forKey: "transactionId")!)
        db.collection("transactions").document(UserDefaults.standard.string(forKey: "transactionId")!).addSnapshotListener {
            documentSnapshot, error in
            guard let document = documentSnapshot else {
                print("No documents")
                
                return
                
            }
            //transactionの
            let data = ((document.data())!)
            print(data)
            //self.transactionId = UserDefaults.standard.string(forKey: "transactionId")!
            self.delivery = data["delivery"] as? Int ?? 0
            self.name = data["name"] as? String ?? ""
            self.startlocation = data["startlocation"] as? String ?? ""
            self.destination = data["destination"] as? String ?? ""
            self.detail = data["detail"] as? String ?? ""
            self.price = data["price"] as? Int ?? 0
            self.rating = data["rating"] as? String ?? ""
            
            
//            self.pashiriContact = Contact(transactionId: transactionId, delivery: delivery, startlocation: startlocation, destination: destination, detail: detail, name: name, price: price, rating: rating)
        }
    }
   
    
    
}
