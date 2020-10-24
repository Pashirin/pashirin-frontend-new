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
//        if didStartTrip {
//            Deliver()
//        } else {
            
            ZStack {
                Color.blue.edgesIgnoringSafeArea(.all)
                VStack{
                    Text("Congratulations!")
                        .padding(.top, 50)
                        .font(.system(size: 21, weight: .medium, design: .default))
                    Image("pashirin")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 60, height: 60)
                    Text("You have a Match!")
//                    HStack{
//                        Button(action: {
//                            print("Button Clicked")
//                        }) {
//
//                            Text("Chat Now")
//                                .foregroundColor(.white)
//                                .font(.title)
//                                .padding()
//                                .border(Color.white, width: 5)
//                        }
//                        NavigationView {
//                            NavigationLink(destination: Home()){
//                                Text("Chat juyjyu Now")
//                            }
//                        }
//                    }
                    
                    Button(action: {
                        print(self.transactionId)
                        Firestore.firestore().collection("transactions").document(self.transactionId).setData(["status": 3], merge: true)
                        self.didStartTrip.toggle()
            
                    }) {
                        
                        Text("Begin Trip")
                            .foregroundColor(.white)
                            .font(.title)
                            .padding()
                            .border(Color.white, width: 5)
                    }
                    
                    Button (action: {
                        self.showHome.toggle()
                    }) {
                        Text("Chat with Customer")
                            .foregroundColor(.white)
                            .font(.title)
                            .padding()
                            .border(Color.white, width: 5)
                    }.sheet(isPresented: $showHome) {
                        Home()
                    }
                    
                    
                }
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
