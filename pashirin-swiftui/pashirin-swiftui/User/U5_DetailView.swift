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
    @ObservedObject var pashiriData = DataViewModel()
    @ObservedObject var waitingViewModel = WaitingViewModel()

    @State var showCongrats = true
    
    
    
    let db = Firestore.firestore()
    
    var body: some View {
        if showCongrats {
            U5_Congrats(showCongrats: $showCongrats)
        } else if self.waitingViewModel.status == 4{
            Thankyou()
        } else {
            VStack {
                Image("profile")
                    .resizable()
                    .clipped()
                    .cornerRadius(50)
            }
            .frame(width: 150, height: 150)
            
//            Text(pashiriData.name as! String)
//                .font(.title)
//                .fontWeight(.medium)
//            Text(pashiriData.rating as! String)
            
            Form{
                Section{
                    HStack{
                        Text("Offer Price")
                        Spacer()
                        Text("¥\(self.pashiriData.price as! Int)")
                            .foregroundColor(.gray)
                            .font(.callout)
                    }
                    HStack{
                        Text("Rating")
                        Spacer()
                        Text(self.pashiriData.rating as! String)
                            .foregroundColor(.gray)
                            .font(.callout)
                        
                    }
                    HStack{
                        Text("Current Location")
                        Spacer()
                        Text(self.pashiriData.startlocation as! String)
                            .foregroundColor(.gray)
                            .font(.callout)
                    }
                    HStack{
                        Text("Delivery")
                        Spacer()
                        Text("\(self.pashiriData.delivery as! Int) completed deliveries")
                            .foregroundColor(.gray)
                            .font(.callout)
                    }
                    HStack{
                        Text("Message")
                        Spacer()
                        Text(self.pashiriData.detail as! String)
                            .foregroundColor(.gray)
                            .font(.callout)
                    }
                    
                }
                
                Section{
//                    NavigationLink(destination: Home()){
//                        Text("Start Chat")
//                    }
                    Button (action : {
                        print("これがstart Chat")
                        
                    }) {
                        Button ("Chat Now"){
                            print("kfjdkfjakdjfkajkj")
                            
                        }
                        .font(.system(size: 18, weight: .bold, design: .default))
                        .multilineTextAlignment(.center)
                        
                    }
                }
            }
            
        }
    }
    
}


struct U5_Congrats: View {
    //var transactionId: String
    @Binding var showCongrats: Bool
    var body: some View{
        //        if didStartTrip {
        //                    Deliver()
        //                } else {
        
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
        
        
        //struct DetailView_Previews: PreviewProvider {
        //    static var previews: some View {
        //        DetailView(contact: contacts[0])
        //            .padding(.top, 40)
        //                }
        //            }
    }
}
