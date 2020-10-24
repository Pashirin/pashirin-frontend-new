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
    @State var name: String = "Pashirin"
    @State var price: Int = 2000
    @State var rating: Int = 0
    @State var startlocation: String = "不明"
    @State var delivery: Int = 50000
    @State var detail: String = ""
    
    @State var item : String = ""
    
   //保留 @ObservedObject var waitingViewModel = WaitingViewModel()

    @State var showCongrats = true
    @State private var showHome = false
    let db = Firestore.firestore()
    
    var body: some View {
        if showCongrats {
            U5_Congrats(showCongrats: $showCongrats)
//                .navigationBarBackButtonHidden(true)
                .onAppear {
                    print("This is U5_DetailView at line 32")
                }
        } else {
            
            ZStack{
                Image("userIcon")
                    .offset(x: 130,y: -350)
                Image("congratsUser")
                    .offset(y:100)
                    .edgesIgnoringSafeArea(.all)
                
                VStack(alignment:.center,spacing: 20){
                    VStack(alignment: .leading, spacing: 10){
                        
                        HStack(spacing: 10){
                            Image(systemName: "face.smiling")
                                .foregroundColor(.gray)
                                .font(.system(size: 30))
                            Text("\(self.name as! String)")
                                .foregroundColor(.gray)
                                .font(.system(size: 20, weight: .bold))
                        }
                        
                        HStack{
                            Image(systemName: "yensign.square")
                                .foregroundColor(.gray)
                                .font(.system(size: 30))
                            Text("\(self.price as! Int)")
                                .foregroundColor(.gray)
                                .font(.system(size: 20, weight: .bold))
                        }
                        
                        HStack{
                            Image(systemName: "cart")
                                .foregroundColor(.gray)
                                .font(.system(size: 30))
                            Text("\(self.item as! String)")
                                .foregroundColor(.gray)
                                .font(.system(size: 20, weight: .bold))
                        }
                        
                        HStack{
                           Image(systemName: "mappin")
                            .foregroundColor(.gray)
                            .font(.system(size: 30))
                            Text(self.startlocation as! String)
                                .foregroundColor(.gray)
                                .font(.system(size: 20, weight: .bold))
                        }
                        
                        HStack{
                          Image(systemName: "doc.plaintext")
                            .foregroundColor(.gray)
                            .font(.system(size: 30))
                            Text("\(self.detail as! String) ")
                                .foregroundColor(.gray)
                                .font(.system(size: 20, weight: .bold))
                        }
                    }
                    .frame(width: 300, height: 300)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 20, style:.continuous))
                    .shadow(color:Color(#colorLiteral(red: 0.1584876558, green: 0.2344628639, blue: 0.4459985033, alpha: 1)) , radius: 3, x: -3, y: -3)
                    .shadow(color:Color(#colorLiteral(red: 0.1584876558, green: 0.2344628639, blue: 0.4459985033, alpha: 1)), radius: 5, x: 5, y: 5)
                    
                    Button(action: {
                        self.showHome.toggle()
                    }){
                        Text("Chat with a Pashirin")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(.gray)
                    }
                    .frame(width: 275, height: 50)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 20, style:.continuous))
                    .shadow(color:Color(#colorLiteral(red: 0.1584876558, green: 0.2344628639, blue: 0.4459985033, alpha: 1)) , radius: 3, x: -3, y: -3)
                    .shadow(color:Color(#colorLiteral(red: 0.1584876558, green: 0.2344628639, blue: 0.4459985033, alpha: 1)), radius: 5, x: 5, y: 5)
                    .sheet(isPresented: $showHome){
                        Home()
                    }
                    .onAppear{
                        getPashiriInfo()
                    }
                }
                .offset(y: 100)
            }
        
        }
    }
    
    
    func getPashiriInfo(){
        self.db.collection("transactions").document(UserDefaults.standard.string(forKey: "transactionId")!).getDocument{ (document, err) in
            if let document = document, document.exists {
                self.item = document.get("item") as! String
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
