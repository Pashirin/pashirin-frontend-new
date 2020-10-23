//
//  U5_Congrats.swift
//  pashirin-swiftui
//
//  Created by あっき on 2020/10/20.
//  Copyright © 2020 HONGHYONGGUK. All rights reserved.
//

import SwiftUI
import FirebaseFirestore

struct U5_Congrats: View {
    //var transactionId: String
    @Binding var showCongrats: Bool
    var body: some View{
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
                HStack{
                    Button(action: {
                        print("Button Clicked")
                        self.showCongrats.toggle()
                        
                    }) {
                        
                        Text("SEE DETAILS")
                            .foregroundColor(.white)
                            .font(.title)
                            .padding()
                            .border(Color.white, width: 5)
                    }
                }
                //                    Button(action: {
                //                        print(self.transactionId)
                //                        Firestore.firestore().collection("transactions").document(self.transactionId).setData(["status": 3], merge: true)
                //                        didStartTrip = true
                //
                //                    }) {
                //
                //                        Text("Begin Trip")
                //                            .foregroundColor(.white)
                //                            .font(.title)
                //                            .padding()
                //                            .border(Color.white, width: 5)
                //                    }
                
                
            }
            
            
        }
//        .navigationBarBackButtonHidden(true)
        .onAppear {
            print("this is U5_Congrats at line 60")
        }
    }
}

