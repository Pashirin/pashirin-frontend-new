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
            Color.green.edgesIgnoringSafeArea(.all)
                .opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)
            VStack{
            Text("Well Done!")
                .padding(.top, 50)
                .font(.title)
            Image("running")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 60, height: 60)
                Text("You Have Completed your Task!")
                    .padding(13.0)
            
                
//                NavigationLink(destination: UserPashirin()){
////                    Button(action: {
////                        print("Button Clicked")
////                    }) {
//
//                        Text("Back to Menu")
//                            .foregroundColor(.white)
//                            .font(.title)
//                            .padding()
//                            .border(Color.white, width: 5)
////                    }
//
//
//                }.navigationBarBackButtonHidden(true)
                
                Button("Go Back", action: {
                    self.presentationMode.wrappedValue.dismiss()
                })
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
