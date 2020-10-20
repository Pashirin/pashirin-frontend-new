//
//  U5_DetailView.swift
//  pashirin-swiftui
//
//  Created by HONGHYONGGUK on 2020/10/16.
//  Copyright © 2020 HONGHYONGGUK. All rights reserved.
//

import SwiftUI
import FirebaseFirestore

struct U5_DetailView: View {
    //Pashiriの情報を取ってくる
    //@ObservedObject var pashiriData = DataViewModel()
    @State var name: String = "名無し"
    @State var price: Int = 2000
    @State var rating: Int = 0
    @State var startlocation: String = "不明"
    @State var delivery: Int = 50000
    @State var detail: String = ""
    
   //保留 @ObservedObject var waitingViewModel = WaitingViewModel()

    @State var showCongrats = true
    @State private var showHome = false
    let db = Firestore.firestore()
    
    var body: some View {
        if showCongrats {
            U5_Congrats(showCongrats: $showCongrats)
        } else {
            VStack{
                
            
            VStack {
                
                Image(systemName: "face.smiling")
                    .resizable()
                    .clipped()
                    .cornerRadius(50)
                    .foregroundColor(Color.gray)
            }
            .frame(width: 150, height: 150)
        
            
            Form{
                Section{
                    HStack{
                        Text("Offer Price")
                        Spacer()
                        Text("¥\(self.price as! Int)")
                            .foregroundColor(.gray)
                            .font(.callout)
                    }
                    HStack{
                        Text("Rating")
                        Spacer()
                        Text("¥\(self.rating as! Int)")
                            .foregroundColor(.gray)
                            .font(.callout)
                        
                    }
                    HStack{
                        Text("Current Location")
                        Spacer()
                        Text(self.startlocation as! String)
                            .foregroundColor(.gray)
                            .font(.callout)
                    }
                    HStack{
                        Text("Delivery")
                        Spacer()
                        Text("\(self.delivery as! Int) completed deliveries")
                            .foregroundColor(.gray)
                            .font(.callout)
                    }
                    HStack{
                        Text("Message")
                        Spacer()
                        Text(self.detail as! String)
                            .foregroundColor(.gray)
                            .font(.callout)
                    }
                    
                }
                
//                Section{
//                    NavigationLink(destination: Home()){
////                        Button (action : {
////                            print("これがstart Chat")
////
////                        }) {
////                            Button ("Chat Now"){
////                                print("kfjdkfjakdjfkajkj")
////
////                            }
////                            .font(.system(size: 18, weight: .bold, design: .default))
////                            .multilineTextAlignment(.center)
////
////                        }
//                        Text("Start Chat")
//
//                    }
//                }
            }
            
            Button(action: {
                self.showHome.toggle()
            }){
                Text("Chat with a Pashiri")
            }.sheet(isPresented: $showHome){
                Home()
            }
            .onAppear{
                getPashiriInfo()
            }
        }
            
        }
    }
    
    
    func getPashiriInfo(){
        self.db.collection("transactions").document(UserDefaults.standard.string(forKey: "transactionId")!).getDocument{ (document, err) in
            if let document = document, document.exists {
                
                self.price = document.get("price")as! Int
                //self.name
                self.startlocation = document.get("startlocation")as! String
                self.detail = document.get("detail")as! String
            } else {
                print("Document does not exist")
            }
            
        }
    }
    
}


