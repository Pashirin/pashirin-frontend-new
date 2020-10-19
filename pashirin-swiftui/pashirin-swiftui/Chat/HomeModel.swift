////
////  HomeModel.swift
////  chatApp4
////
////  Created by Ryu Tamura on 2020/10/15.
////
//import SwiftUI
//import Firebase
//import FirebaseFirestore
//
//class HomeModel: ObservableObject{
//    
//    @Published var txt = ""
//    @Published var msgs : [MsgModel] = []
//    @State var user = UserDefaults.standard.string(forKey: "current_user")
//    @State var transactionId = UserDefaults.standard.string(forKey: "transactionId")
//
//    let ref = Firestore.firestore()
//    
//    init() {
//        readAllMsgs()
//    }
//        
//    func readAllMsgs(){
//        
//        ref.collection(transactionId!).order(by: "timeStamp", descending: false).addSnapshotListener { (snap, err) in
//            
//            if err != nil{
//                print(err!.localizedDescription)
//                return
//            }
//            
//            guard let data = snap else{return}
//            
//            data.documentChanges.forEach { (doc) in
//                
//                // adding when data is added...
//                
//                if doc.type == .added{
//                    
//                    let msg = try! doc.document.data(as: MsgModel.self)!
//                    
//                    DispatchQueue.main.async {
//                        self.msgs.append(msg)
//                    }
//                }
//            }
//        }
//    }
//    
//    func writeMsg(){
//        
//        let msg = MsgModel(msg: txt, user: user ?? "Somebody", timeStamp: Date())
//        
//        let _ = try! ref.collection(transactionId!).addDocument(from: msg) { (err) in
//            
//            if err != nil{
//                print(err!.localizedDescription)
//                return
//            }
// 
//        }
//        
//        self.txt = ""
//    }
//}
//
//
//
//
//struct HomeModel_Previews: PreviewProvider {
//    static var previews: some View {
//        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
//    }
//}
import SwiftUI
import Firebase
import FirebaseFirestore

class HomeModel: ObservableObject{
    
    @Published var txt = ""
    @Published var msgs : [MsgModel] = []
    @State var user = UserDefaults.standard.string(forKey: "current_user")
    @State var transactionId = UserDefaults.standard.string(forKey: "transactionId")

    let ref = Firestore.firestore()
    
    init() {
        readAllMsgs()
    }
        
    func readAllMsgs(){
        
        ref.collection(transactionId!).order(by: "timeStamp", descending: false).addSnapshotListener { (snap, err) in
            
            if err != nil{
                print(err!.localizedDescription)
                return
            }
            
            guard let data = snap else{return}
            
            data.documentChanges.forEach { (doc) in
                
                // adding when data is added...
                
                if doc.type == .added{
                    
                    let msg = try! doc.document.data(as: MsgModel.self)!
                    
                    DispatchQueue.main.async {
                        self.msgs.append(msg)
                    }
                }
            }
        }
    }
    
    func writeMsg(){
        
        let msg = MsgModel(msg: txt, user: user ?? "Somebody", timeStamp: Date())
        
        let _ = try! ref.collection(transactionId!).addDocument(from: msg) { (err) in
            
            if err != nil{
                print(err!.localizedDescription)
                return
            }
 
        }
        
        self.txt = ""
    }
}

struct HomeModel_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
