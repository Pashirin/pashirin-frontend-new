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
                VStack{
                    Color(red: 9/255, green: 91/255, blue: 148/255)
                    .frame(width: 1000, height: 400)
                }
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0,maxHeight: .infinity,alignment: .bottom)
                .edgesIgnoringSafeArea(.bottom)
                
                VStack(alignment:.center,spacing: 40){
                    
                    Image("maps") // live tracking
                        
                    VStack{
                        List{
                            HStack(spacing: 10){
                                Image(systemName: "face.smiling")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 20))
                                    .frame(width:  20)
                                Spacer()
                                Text("\(self.name as! String)")
                                    .foregroundColor(Color(red: 80/255, green:  80/255, blue:  80/255))
                                    .font(.system(size: 20, weight: .bold))
                            }
                            
                            HStack{
                                Image(systemName: "yensign.square")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 20))
                                    .frame(width: 20)
                                Spacer()
                                Text("\(self.price as! Int)")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 20, weight: .bold))
                                    .foregroundColor(Color(red: 80/255, green:  80/255, blue:  80/255))
                            }
                            
                            HStack{
                                Image(systemName: "cart")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 20))
                                    .frame(width: 20)
                                Spacer()
                                Text("\(self.item as! String)")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 20, weight: .bold))
                                    .foregroundColor(Color(red: 80/255, green:  80/255, blue:  80/255))
                            }
                            
                            HStack{
                               Image(systemName: "mappin")
                                .foregroundColor(.gray)
                                .font(.system(size: 20))
                                .frame(width: 20)
                                Spacer()
                                Text(self.startlocation as! String)
                                    .foregroundColor(.gray)
                                    .font(.system(size: 20, weight: .bold))
                                    .foregroundColor(Color(red: 80/255, green:  80/255, blue:  80/255))
                            }
                            
                            HStack{
                              Image(systemName: "doc.plaintext")
                                .foregroundColor(.gray)
                                .frame(width: 20)
                                Spacer()
                                Text("\(self.detail as! String) ")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 20, weight: .bold))
                                    .foregroundColor(Color(red: 80/255, green:  80/255, blue:  80/255))
                            }
                        }
                        .frame(width: 300, height: 250)
                        .background(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 15, style:.continuous))
                        .shadow(color:Color.black.opacity(0.25),  radius: 5, x: 3, y: 3)
                    }
                    
                                    
                    Button(action: {
                        self.showHome.toggle()
                    }){
                        Text("Chat with a Pashirin")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(Color(red: 111/255, green: 111/255, blue: 111/255))
                    }
                    .frame(width: 250, height: 50)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 15, style:.continuous))
                    .shadow(color:Color.black.opacity(0.25),  radius: 5, x: 3, y: 3)
                    .sheet(isPresented: $showHome){
                        Home()
                    }
                    
                }
              
            }
            .onAppear{
                getPashiriInfo()
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
