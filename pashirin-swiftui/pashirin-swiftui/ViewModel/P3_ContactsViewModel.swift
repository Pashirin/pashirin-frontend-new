//
//  BooksViewModel.swift
//  dataFetch
//
//  Created by Eri Koyano on 2020/10/12.
//

import Foundation
import FirebaseFirestore

class ContactsViewModel: ObservableObject {
    @Published var contacts = [Contact]()
    
    private var db = Firestore.firestore()
    //これだと全てのトランズアクションを取得してしまう
    func fetchData(){
        db.collection("transactions").whereField("status", isEqualTo: 1).addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else{
                print("No documents")
                return
            }
            //transactionの
            self.contacts = documents.map { (queryDocumentSnapshot) -> Contact in
            
                
                let data = queryDocumentSnapshot.data()
                let transactionId = queryDocumentSnapshot.documentID
                let delivery = data["delivery"] as? Int ?? 0
                let name = data["name"] as? String ?? ""
                let startlocation = data["startlocation"] as? String ?? ""
                let destination = data["destination"] as? String ?? ""
                let detail = data["detail"] as? String ?? ""
                let price = data["price"] as? Int ?? 0
                let rating = data["rating"] as? String ?? ""
                print("これが", transactionId)
                
                return Contact (transactionId: transactionId, delivery: delivery,startlocation: startlocation, destination: destination, detail: detail, name: name, price: price, rating: rating)
            }
        }
    }
   
    
    
}
