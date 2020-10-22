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
            ZStack{
                Image("congratsUser")
                    .offset(y:100)
                    .edgesIgnoringSafeArea(.all)
                
//                VStack {
//
//                    // map view
//                }
//                .frame(width: 325, height: 260)
//
            
                VStack(spacing: 50){
                    VStack(spacing: 20){

                        HStack{
                            Image(systemName: "face.smiling")
                                .foregroundColor(.gray)
                            Text("pashirin Name")
                                .foregroundColor(.gray)
                                .font(.system(size: 20, weight: .bold))
            
                        }
                        
                        HStack{
                            Image(systemName: "yensign.square")
                                .foregroundColor(.gray)
                            Text("¥\(self.price as! Int)")
                                .foregroundColor(.gray)
                                .font(.system(size: 20, weight: .bold))
                        }
                       
                        HStack{
                            Image(systemName: "cart")
                                .foregroundColor(.gray)
                            Text("¥\(self.rating as! Int)")
                                .foregroundColor(.gray)
                                .font(.system(size: 20, weight: .bold))
                        }
                        
                        HStack{
                           Image(systemName: "mappin")
                            .foregroundColor(.gray)
                            Text(self.startlocation as! String)
                                .foregroundColor(.gray)
                                .font(.system(size: 20, weight: .bold))
                        }
                        
                        HStack{
                          Image(systemName: "doc.plaintext")
                            .foregroundColor(.gray)
                            Text("\(self.delivery as! Int) completed deliveries")
                                .foregroundColor(.gray)
                                .font(.callout)
                        }
                    }
                    .frame(width: 300, height: 500)
                    .background(Color.white)
                    
                    .clipShape(RoundedRectangle(cornerRadius: 20, style:.continuous))
                    .shadow(color:Color(#colorLiteral(red: 0.1177307457, green: 0.1739197891, blue: 0.3294346426, alpha: 1)) , radius: 5, x: 5, y: 5)
                    .shadow(color:Color(#colorLiteral(red: 0.1177307457, green: 0.1739197891, blue: 0.3294346426, alpha: 1)), radius: 5, x: -5, y: -5)
                            
                
                    Button(action: {
                        self.showHome.toggle()
                    }){
                        Text("Chat with a Pashirin")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(.white)
                    }.sheet(isPresented: $showHome){
                        Home()
                    }
                    .onAppear{
                        getPashiriInfo()
                    }
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


