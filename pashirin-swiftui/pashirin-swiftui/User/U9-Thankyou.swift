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
               LottieView(filename: "halloween2")
                .frame(width: 300, height: 300)
                VStack{
                    Text("Task Completed!")
                        .fontWeight(.bold)
                        .foregroundColor(.gray)
                    
                }
                
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }){
                    Text("Back to Home")
                        .font(.system(size: 18))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                }
                .frame(width:200 ,height: 50)
                .padding(.leading,5)
                .background(Color(red: 6/255, green: 91/255, blue: 148/255))
                .clipShape(RoundedRectangle(cornerRadius: 20, style:.continuous))
                .shadow(color:Color(red: 217/255, green: 217/255, blue: 217/255) , radius: 10, x: 5, y: 5)
                .shadow(color:Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)), radius: 10, x: -5, y: -5)
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

