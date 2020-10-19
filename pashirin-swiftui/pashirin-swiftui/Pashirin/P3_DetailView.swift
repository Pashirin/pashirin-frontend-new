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
            ContainerForStatus()
        } else {
           
//            VStack {
//                Image("profile")
//                    .resizable()
//                    .clipped()
//                    .cornerRadius(50)
//            }
//            .frame(width: 150, height: 150)
            
            Text(contact.name)
                .font(.title)
                .fontWeight(.medium)
            Text(contact.rating)
            
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
//                    NavigationView{
//                        NavigationLink(destination: Home()){
//                            Text("Start Chat")
//                        }
//                    }
                    Button (action : {
                        print("これがstart Chat")
                        
                    }) {
                        Button ("Confirm to Deliver"){
                            print("transactionIdは　　　", self.transactionId)
                            print("pashiri_id は　　　", self.pashiri_id)
                            db.collection("transactions").document(contact.transactionId).setData(["status": 2], merge: true)
                            UserDefaults.standard.set(contact.transactionId, forKey: "transactionId")
                            print(UserDefaults.standard.string(forKey: "transactionId"))
                            
                            db.collection("transactions").document(contact.transactionId).setData(["pashiri_id": UserDefaults.standard.string(forKey:"current_user_id")], merge: true)
                            self.showCongrats.toggle()
                            
                        }
                        .font(.system(size: 18, weight: .bold, design: .default))
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
                        
                    }
                }
            }
            
            
        }
    }
    
}

struct P3_Congrats: View {
    var transactionId = UserDefaults.standard.string(forKey:"transactionId")!
    @State var didStartTrip = false
    var body: some View{
        if didStartTrip {
            Deliver()
        } else {
            
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
                        NavigationView {
                            NavigationLink(destination: Home()){
                                Text("Chat juyjyu Now")
                            }
                        }
                    }
                    Button(action: {
                        print(self.transactionId)
                        Firestore.firestore().collection("transactions").document(self.transactionId).setData(["status": 3], merge: true)
                        didStartTrip = true
            
                    }) {
                        
                        Text("Begin Trip")
                            .foregroundColor(.white)
                            .font(.title)
                            .padding()
                            .border(Color.white, width: 5)
                    }
                    
                    
                }
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

