//
//  P5-Deliver.swift
//  StaticPages
//
//  Created by Eri Koyano on 2020/10/12.
//

import Foundation
import SwiftUI
import FirebaseFirestore
// to be overlayed on top of 
struct Deliver: View {
    let db = Firestore.firestore()
    var body: some View{
        ZStack {
            
                
            VStack(spacing: 100){
                VStack(spacing: 20){
                    Text("Currently Delivering...")
                        .fontWeight(.bold)
                        .font(.system(size: 18))
                        .foregroundColor(.gray)
                    
                    Image("bicycle") // chage to animatin!
                }
                
                Button(action: {
                    print("Button Clicked")
                    db.collection("transactions").document(UserDefaults.standard.string(forKey: "transactionId")!).setData(["status":4], merge: true)
                    }) {
                    
                        Text("Completed")
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                    }
                    .frame(width: 275, height: 50)
                    .background(Color(red: 254/255, green: 163/255, blue: 93/255))
                    .clipShape(RoundedRectangle(cornerRadius: 20, style:.continuous))
                    .shadow(color:Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)) , radius: 10, x: 5, y: 5)
                    .shadow(color:Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)), radius: 10, x: -5, y: -5)
                }
        }
    }
}


struct Deliver_Previews: PreviewProvider {
    static var previews: some View {
        Deliver()
    }
}

