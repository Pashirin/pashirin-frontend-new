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
    var locationManager = LocationManager()

    var body: some View{
        ZStack {
            
                
            VStack(spacing: 50){
                VStack(spacing: 20){
                    Text("Currently Delivering...")
                        .fontWeight(.bold)
                        .font(.system(size: 18))
                        .foregroundColor(Color(red: 80/255, green: 80/255, blue: 80/255))
                    
                    LottieView(filename: "Ready")
                        .frame(width: 350, height: 400)
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
                    .clipShape(RoundedRectangle(cornerRadius: 15, style:.continuous))
                    .shadow(color:Color.black.opacity(0.25),  radius: 5, x: 3, y: 3)
                }
        }
    }
}


struct Deliver_Previews: PreviewProvider {
    static var previews: some View {
        Deliver()
    }
}

