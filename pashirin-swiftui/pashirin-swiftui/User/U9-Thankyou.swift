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
            Color.yellow.edgesIgnoringSafeArea(.all)
                .opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)
            VStack{
            Text("Thank You!")
                .padding(.top, 50)
                .font(.title)
//            Image("running")
//                .resizable()
//                .aspectRatio(contentMode: .fit)
//                .frame(width: 60, height: 60)
//                Text("We Hope You Enjoyed the Service!")
//                    .padding(13.0)
                
            
//            Button(action: {
//                    print("Button Clicked")
//
//
//                }) {
//
//                    Text("Back to Menu")
//                        .foregroundColor(.white)
//                        .font(.title)
//                        .padding()
//                        .border(Color.white, width: 5)
//                }
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

