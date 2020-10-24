//
//  U9-Thankyou.swift
//  StaticPages
//
//  Created by Eri Koyano on 2020/10/12.
//

import Foundation
import SwiftUI

struct Thankyou: View {
    @Environment(\.presentationMode) var presentationMode
    var body: some View{
        ZStack {
            
            VStack(spacing: 20){
                Image("completed-1")
                    
                VStack{
                    Text("Task Completed!")
                        .fontWeight(.bold)
                        .foregroundColor(.gray)
                    
                }
                
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }){
                    Text("Back to Home")
                }
                .navigationBarTitle("")
                .navigationBarBackButtonHidden(true)
                }
        }.onAppear {
            print("Hello This is U9")
            var transactionId = UserDefaults.standard.string(forKey: "transactionId")
            print(transactionId ?? "Transaction ID has been cleared")
            UserDefaults.standard.removeObject(forKey: "transactionId")
            transactionId = UserDefaults.standard.string(forKey: "transactionId")
            print(transactionId ?? "Transaction ID has been cleared")
        }
    }
}


struct Thankyou_Previews: PreviewProvider {
    static var previews: some View {
        Thankyou()
    }
}

