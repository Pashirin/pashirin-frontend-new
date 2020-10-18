//
//  DetailView.swift
//  NavView
//
//  Created by Eri Koyano on 2020/10/07.
//

import SwiftUI
import FirebaseFirestore
import Lottie

struct P3_DetailView: View {
    
    let contact: Contact
    @State var showCongrats = false
    
    
    let db = Firestore.firestore()
    
    var body: some View {
        if showCongrats {
            P3_Congrats(transactionId: contact.transactionId)
        } else {
        ZStack{
                Image("P2")
                .resizable()
                 .scaledToFill()
                 .edgesIgnoringSafeArea(.all)
                
        VStack {
                Image("profile")
                    .resizable()
                    .clipped()
                    .cornerRadius(50)
                    .frame(width: 150, height: 150)
                
                Text("ERI")
                    .font(Font.custom("LEMONMILK-Light",size: 30))
                    .fontWeight(.medium)
                Text(contact.rating)
           
            
        Form{
                Section{
                    HStack{
                        Text(LocalizedStringKey("Offer Price"))
                        Spacer()
                        Text("¥\(contact.price)")
                            .foregroundColor(.gray)
                            .font(.callout)
                    }
                    HStack{
                        Text(LocalizedStringKey("Rating"))
                        Spacer()
                        Text(contact.rating)
                            .foregroundColor(.gray)
                            .font(.callout)
                        
                    }
                    HStack{
                        Text(LocalizedStringKey("Current Location"))
                        Spacer()
                        Text(contact.startlocation)
                            .foregroundColor(.gray)
                            .font(.callout)
                    }
                    HStack{
                        Text(LocalizedStringKey("Delivery"))
                        Spacer()
                        Text("\(contact.delivery) completed deliveries")
                            .foregroundColor(.gray)
                            .font(.callout)
                    }
                    HStack{
                        Text(LocalizedStringKey("Message"))
                        Spacer()
                        Text(contact.detail)
                            .foregroundColor(.gray)
                            .font(.callout)
                    }
                }
            }
        
                    Button(action : {
                        print("Button Clicked")
                        db.collection("transactions").document(contact.transactionId).setData(["status": 2], merge: true)
                        self.showCongrats.toggle()
                        
                    }) {
                        Text("Confirm to Deliver")
                            .multilineTextAlignment(.center)
                        }
                  //  .font(.system(size: 18, weight: .bold, design: .default))
                    .font(Font.custom("Barlow-Medium",size: 18))
                        }
                    }
                }
            }
        }



    



struct P3_Congrats: View {
    var transactionId: String
    @State var didStartTrip = false
    var body: some View{
        if didStartTrip {
            Deliver()
        } else {
            
            ZStack {
                Spacer()
               Image("P3Congrats")
                   .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)

                VStack{
                 Text(LocalizedStringKey("Congratulations"))
                     .padding(.top, 50)
                     .font(Font.custom("LEMONMILK-Light",size: 30))
                     .foregroundColor(.white)
                 
                 LottieView(filename: "Congrats")
                     .frame(width: 60, height: 60)
                     Text(LocalizedStringKey("You have a Match"))
                         .padding(13.0)
                         .font(Font.custom("Barlow-Medium",size: 24))
                         .foregroundColor(.white)
                    
                    HStack{
                        Button(action: {
                                print("Button Clicked")
                            }) {
                            
                                Text(LocalizedStringKey("Chat"))
                                    .foregroundColor(Color(.lightGray))
                                    .padding()
                                    .font(Font.custom("LEMONMILK-Light",size: 21))
                                    .overlay(
                                    RoundedRectangle(cornerRadius: 26)
                                        .stroke(Color(.lightGray),lineWidth: 5))
                            }
                    }
                    Button(action: {
                        print(self.transactionId)
                        Firestore.firestore().collection("transactions").document(self.transactionId).setData(["status": 3], merge: true)
                        didStartTrip = true
            
                    }) {
                        
                        Text("Begin Trip")
                            .foregroundColor(Color(.lightGray))
                            .padding()
                            .font(Font.custom("LEMONMILK-Light",size: 21))
                            .overlay(
                            RoundedRectangle(cornerRadius: 26)
                                .stroke(Color(.lightGray),lineWidth: 5))
                    }
                    
                    
                }
            }
            
        }
        
        
//        struct P3_DetailView_Previews: PreviewProvider {
//            static var previews: some View {
//                P3_DetailView(contact: contacts[0])
//
//                        }
//                    }
    }
}



