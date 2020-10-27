//
//  TaskComplete.swift
//  StaticPages
//
//  Created by Eri Koyano on 2020/10/12.
//

import Foundation
import SwiftUI

struct TaskComplete: View {
    @Environment(\.presentationMode) var presentationMode
    var body: some View{
        ZStack {
            VStack{
                Color(red: 254/255, green: 163/255, blue: 93/255)
                .frame(width: 1000, height: 400)
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0,maxHeight: .infinity,alignment: .bottom)
            .edgesIgnoringSafeArea(.bottom)

       
        
            VStack(spacing: 150){
                VStack(spacing: 30){
                    VStack(spacing: 5){
                        Text("Well Done!")
                            .fontWeight(.bold)
                            .font(.system(size: 24))
                            .foregroundColor(Color(red: 80/255, green: 80/255, blue: 80/255))
                        
                        Text("You Have Completed your Task!")
                            .font(.system(size: 18))
                            .foregroundColor(.gray)
                    }
                    
                    
                    LottieView(filename: "Basket")
                        .frame(width: 300, height: 300)
                }
               
                

                Button("Back to Home", action: {
                    self.presentationMode.wrappedValue.dismiss()
                })
                .foregroundColor(Color(red: 80/255, green: 80/255, blue: 80/255))
                .frame(width: 200, height: 50)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 20, style:.continuous))
                .shadow(color:Color.black.opacity(0.25),  radius: 5, x: 3, y: 3)
                .navigationBarBackButtonHidden(true)
                
            }
                
        }.onAppear {
            print("Hi This is P8")
            var transactionId = UserDefaults.standard.string(forKey: "transactionId")
            print(transactionId ?? "Transaction ID has been cleared")
            UserDefaults.standard.removeObject(forKey: "transactionId")
            transactionId = UserDefaults.standard.string(forKey: "transactionId")
            print(transactionId ?? "Transaction ID has been cleared")
            print("done")
        }
    }
}


struct TaskComplete_Previews: PreviewProvider {
    static var previews: some View {
        TaskComplete()
    }
}
