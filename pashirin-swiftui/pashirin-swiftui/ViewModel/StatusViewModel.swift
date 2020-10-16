//
//  StatusViewModel.swift
//  pashirin-swiftui
//
//  Created by HONGHYONGGUK on 2020/10/15.
//  Copyright © 2020 HONGHYONGGUK. All rights reserved.
//

import Foundation
import Firebase
//userdefaulに保存されているtrasactionIdを使ってfirestoreから最新のstatusを取得するコントローラー
class StatusViewModel: ObservableObject{
    var transactionId: String
    private var db = Firestore.firestore().collection("transaction")
    
    init(){
        self.transactionId = UserDefaults.standard.string(forKey: "transactionId") ?? ""
    }
    
    func getStatus() -> Int {
        print("StatusViewModel.transactionIdの値は",self.transactionId)
        if self.transactionId == "" {
            return 0
        } else {
            db.document(self.transactionId).getDocument{ (document, error) in
                if let document = document, document.exists {
                    let data = document.data().map(String.init(describing:)) ?? "nil"
                    print("Dcument data: \(data)")
                } else {
                    print("getStatus失敗")
                }
            }
        }
        return 0
    }
}
