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

       
        
            VStack(spacing: 250){
                VStack(spacing: 30){
                    VStack(spacing: 5){
                        Text("Well Done!")
                            .fontWeight(.bold)
                            .font(.system(size: 20))
                            .foregroundColor(.gray)
                        
                        Text("You Have Completed your Task!")
                            .font(.system(size: 16))
                            .foregroundColor(.gray)
                    }
                    
                    
                    Image(systemName: "face.smiling") //
                        .frame(width: 60, height: 60)
                        .background(Color.gray)
                    
                }
               
                

                Button("Back to Home", action: {
                    self.presentationMode.wrappedValue.dismiss()
                })
                .foregroundColor(Color.gray)
                .frame(width: 200, height: 50)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 20, style:.continuous))
                .shadow(color:Color(#colorLiteral(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 1)) , radius: 10, x: 5, y: 5)
                .shadow(color:Color(#colorLiteral(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 1)), radius: 10, x: -5, y: -5)
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
