//
//  P3_Congrats.swift
//  pashirin-swiftui
//
//  Created by Ryu Tamura on 2020/10/22.
//  Copyright © 2020 HONGHYONGGUK. All rights reserved.
//

import SwiftUI
import FirebaseFirestore

struct P3_Congrats: View {
    var transactionId = UserDefaults.standard.string(forKey:"transactionId")!
    @State var didStartTrip = false
    @State private var showHome = false
    
    var body: some View {

            
            ZStack {
                VStack{
                    Color(red: 254/255, green: 163/255, blue: 93/255)
                    .frame(width: 1000, height: 300)
                }
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0,maxHeight: .infinity,alignment: .top)
                .edgesIgnoringSafeArea(.top)
                
               
                VStack(spacing: 100){
                    VStack(spacing: 20){
                        Text("...on the way!")
                            .font(.system(size: 18, weight: .bold, design: .default))
                            .foregroundColor(.gray)
                        Image("lamp")
                            .frame(width: 60, height: 60)
                    }
                    
                 
                    VStack(spacing: 30){
                        Button(action: {
                            print(self.transactionId)
                            Firestore.firestore().collection("transactions").document(self.transactionId).setData(["status": 3], merge: true)
                            self.didStartTrip.toggle()
                
                        }) {
                            
                            Text("Begin Trip")
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                                .font(.system(size: 18))
                               
                        }
                        .frame(width: 275, height: 50)
                        .background(Color(red: 254/255, green: 163/255, blue: 93/255))
                        .clipShape(RoundedRectangle(cornerRadius: 20, style:.continuous))
                        .shadow(color:Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)) , radius: 10, x: 5, y: 5)
                        .shadow(color:Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)), radius: 10, x: -5, y: -5)
                        .navigationBarBackButtonHidden(true)
                        
                        Button (action: {
                            self.showHome.toggle()
                        }) {
                            Text("Chat with namaken")
                                .foregroundColor(.gray)
                                .font(.system(size: 18))
                                .fontWeight(.bold)
                            
                        }.sheet(isPresented: $showHome) {
                            Home()
                        }
                        .frame(width: 275, height: 50)
                        .background(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 20, style:.continuous))
                        .shadow(color:Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)) , radius: 10, x: 5, y: 5)
                        .shadow(color:Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)), radius: 10, x: -5, y: -5)
                        .navigationBarBackButtonHidden(true)
                    }
                   
                    
                }
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0,maxHeight: .infinity,alignment: .center)
          
            }
            .navigationBarBackButtonHidden(true)
            
//        }
        
        
        //struct DetailView_Previews: PreviewProvider {
        //    static var previews: some View {
        //        DetailView(contact: contacts[0])
        //            .padding(.top, 40)
        //                }
        //            }
    }
}

struct P3_Congrats_Previews: PreviewProvider {
    static var previews: some View {
        P3_Congrats()
    }
}
