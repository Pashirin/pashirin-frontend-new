//
//  DetailView.swift
//  NavView
//
//  Created by Eri Koyano on 2020/10/07.
//
import SwiftUI
import FirebaseFirestore
struct P3_DetailView: View {
    let contact: Contact
    @State var showCongrats = false
    let db = Firestore.firestore()
    let transactionId = UserDefaults.standard.string(forKey: "transactionId")
    let pashiri_id = UserDefaults.standard.string(forKey: "current_user_id")
    var body: some View {
        if showCongrats {
            P3_Congrats(transactionId: contact.transactionId)
        } else {
            VStack {
                Image("profile")
                    .resizable()
                    .clipped()
                    .cornerRadius(50)
                    .frame(width: 150, height: 150)
                Text("Eri")
                .font(.title)
                .fontWeight(.medium)
           // Text(contact.rating)
            }
            Form{
                Section{
                    HStack{
                        Text("Offer Price")
                        Spacer()
                        Text("¥\(contact.price)")
                            .foregroundColor(.gray)
                            .font(.callout)
                    }
                    HStack{
                        Text("Rating")
                        Spacer()
                        Text(contact.rating)
                            .foregroundColor(.gray)
                            .font(.callout)
                    }
                    HStack{
                        Text("Current Location")
                        Spacer()
                        Text(contact.startlocation)
                            .foregroundColor(.gray)
                            .font(.callout)
                    }
                    HStack{
                        Text("Delivery")
                        Spacer()
                        Text("\(contact.delivery) completed deliveries")
                            .foregroundColor(.gray)
                            .font(.callout)
                    }
                    HStack{
                        Text("Message")
                        Spacer()
                        Text(contact.detail)
                            .foregroundColor(.gray)
                            .font(.callout)
                    }
                }
                Section{
                    Button (action : {
                        print("これがstart Chat")
                    }) {
                        Button ("Confirm to Deliver"){
                            print("transactionIdは　　　", self.transactionId)
                            print("pashiri_id は　　　", self.pashiri_id)
                            db.collection("transactions").document(contact.transactionId).setData(["status": 2], merge: true)
                            print(UserDefaults.standard.string(forKey: "transactionId"))
                            db.collection("transactions").document(contact.transactionId).setData(["pashiri_id": UserDefaults.standard.string(forKey:"current_user_id")], merge: true)
                            self.showCongrats.toggle()
                        }
                        .font(.system(size: 18, weight: .bold, design: .default))
                        .multilineTextAlignment(.center)
                    }
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

    }
}
