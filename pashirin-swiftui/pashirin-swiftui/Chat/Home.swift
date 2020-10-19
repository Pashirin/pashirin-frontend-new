////
////  Home.swift
////  chatApp4
////
////  Created by Ryu Tamura on 2020/10/15.
////
//import SwiftUI
//
//struct Home: View {
//    
//    @ObservedObject var homeData = HomeModel()
//    @State private var user = UserDefaults.standard.string(forKey: "current_user")
//    @State private var transactionID = UserDefaults.standard.string(forKey: "transactionId")
//    @State var scrolled = false
//    
//    var body: some View {
//        
//        VStack(spacing: 0){
//
//            HStack{
//                
//                Text("Pashirin Chat")
//                    .font(.title)
//                    .fontWeight(.heavy)
//                    .foregroundColor(.white)
//                    .multilineTextAlignment(.center)
//                
//                Spacer(minLength: 0)
//            }
//            .padding()
//            .padding(.top,UIApplication.shared.windows.first?.safeAreaInsets.top)
//            .background(Color(red: 0.97, green: 0.30, blue: 0.31))
//            
//            ScrollViewReader{reader in
//                
//                ScrollView{
//                    
//                    VStack(spacing: 15){
//                        
//                        ForEach(homeData.msgs){msg in
//                            
//                           ChatRow(chatData: msg)
//                            .onAppear{
//                                // First Time Scroll
//                                if msg.id == self.homeData.msgs.last!.id && !scrolled{
//                                    
//                                    reader.scrollTo(homeData.msgs.last!.id,anchor: .bottom)
//                                    scrolled = true
//                                }
//                            }
//                        }
//                        .onChange(of: homeData.msgs, perform: { value in
//                            
//                            // You can restrict only for current user scroll....
//                            reader.scrollTo(homeData.msgs.last!.id,anchor: .bottom)
//                        })
//                    }
//                    .padding(.vertical)
//                }
//            }
//            
//            HStack(spacing: 15){
//                
//                TextField("Enter Message", text: $homeData.txt)
//                    .padding(.horizontal)
//                    // Fixed Height For Animation...
//                    .frame(height: 45)
//                    .background(Color.primary.opacity(0.06))
//                    .clipShape(Capsule())
//                
//                if homeData.txt != ""{
//                    
//                    Button(action: homeData.writeMsg, label: {
//                        
//                        Image(systemName: "paperplane.fill")
//                            .font(.system(size: 22))
//                            .foregroundColor(.white)
//                            .frame(width: 45, height: 45)
//                            .background(Color(red: 0.062, green: 0.553, blue: 0.979))
//                            .clipShape(Circle())
//                    })
//                }
//            }
//            .animation(.default)
//            .padding()
//        }
//        .ignoresSafeArea(.all, edges: .top)
//    }
//}

import SwiftUI
struct Home: View {
    
    //    @StateObject var homeData = HomeModel()
    @ObservedObject var homeData = HomeModel()
    @State private var user = UserDefaults.standard.string(forKey: "current_user")
    @State private var transactionId = UserDefaults.standard.string(forKey: "transactionId")
    @State var scrolled = false
    
    var body: some View {
        
        VStack(spacing: 0){
            HStack{
                Spacer(minLength: 0)
                
                Text("Pashirin Chat")
                    .font(.title)
                    .fontWeight(.heavy)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                
                //                Spacer(minLength: 0)
            }
            .padding()
            .padding(.top,UIApplication.shared.windows.first?.safeAreaInsets.top)
            .background(Color(red: 0.97, green: 0.30, blue: 0.31))
            
            //            ScrollViewReader{reader in
            
            ScrollView{
                
                VStack(spacing: 15){
                    
                    ForEach(homeData.msgs){msg in
                        
                        ChatRow(chatData: msg)
                            .onAppear{
                                // First Time Scroll
                                //                                if msg.id == self.homeData.msgs.last!.id && !scrolled{
                                //
                                //                                    reader.scrollTo(homeData.msgs.last!.id,anchor: .bottom)
                                //                                    scrolled = true
                                //                                }
                                scrolled = true
                            }
                    }
                    //                        .onChange(of: homeData.msgs, perform: { value in
                    //
                    //                            // You can restrict only for current user scroll....
                    //                            reader.scrollTo(homeData.msgs.last!.id,anchor: .bottom)
                    //                        })
                }
                .padding(.vertical)
            }
            //            }
            
            HStack(spacing: 15){
                
                TextField("Enter Message", text: $homeData.txt)
                    .padding(.horizontal)
                    // Fixed Height For Animation...
                    .frame(height: 45)
                    .background(Color.primary.opacity(0.06))
                    .clipShape(Capsule())
                
                if homeData.txt != ""{
                    
                    Button(action: homeData.writeMsg, label: {
                        
                        Image(systemName: "paperplane.fill")
                            .font(.system(size: 22))
                            .foregroundColor(.white)
                            .frame(width: 45, height: 45)
                            .background(Color(red: 0.062, green: 0.553, blue: 0.979))
                            .clipShape(Circle())
                    })
                }
            }
            .animation(.default)
            .padding()
        }
        //        .ignoresSafeArea(.all, edges: .top)
    }
}

