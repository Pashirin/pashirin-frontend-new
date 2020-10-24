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
                

                VStack(spacing:50){
                    Image("spaceships")
                    VStack(alignment: .leading, spacing: 20){
                        
                        HStack{
                            Image(systemName: "yensign.square")
                                .font(.system(size: 40))
                                .foregroundColor(.gray)
                               
                            Text("¥\(contact.price)")
                                .foregroundColor(.gray)
                                .fontWeight(.bold)
                                .font(.system(size: 30))
                                .onAppear {
                                    print("This is P3_DetailView and tID is \(String(describing: self.transactionId))")
                                }
                        }
                        
                        HStack{
                            Image(systemName: "cart")
                                .font(.system(size: 40))
                                .foregroundColor(.gray)
                                
                            Text("\(contact.item)")
                                .foregroundColor(.gray)
                                .fontWeight(.bold)
                                .font(.system(size: 30))
                        }
//
        
                        HStack{
                            Image(systemName: "mappin")
                                .font(.system(size: 40))
                                .foregroundColor(.gray)
                               
                            Text(contact.startlocation)
                                .foregroundColor(.gray)
                                .fontWeight(.bold)
                                .font(.system(size: 30))
                        }
                    

                        HStack{
                            Image(systemName: "doc.text")
                                .font(.system(size: 40))
                                .foregroundColor(.gray)
                            Text(contact.detail)
                                .foregroundColor(.gray)
                                .fontWeight(.bold)
                                .font(.system(size: 30))
                             
                           
                        }
                    }
                    .frame(width: 300, height: 300)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 20, style:.continuous))
                    .shadow(color:Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)) , radius: 10, x: 5, y: 5)
                    .shadow(color:Color(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)), radius: 10, x: -5, y: -5)
                    
                    
                 
                        Button (action : {
                            print("これがstart Chat")
                            
                        }) {
                            Button("Confirm to Deliver"){
                                print("transactionIdは　　　", self.transactionId)
                                print("pashiri_id は　　　", self.pashiri_id)
                                db.collection("transactions").document(contact.transactionId).setData(["status": 2], merge: true)
                                UserDefaults.standard.set(contact.transactionId, forKey: "transactionId")
                                print(UserDefaults.standard.string(forKey: "transactionId"))
                                
                                db.collection("transactions").document(contact.transactionId).setData(["pashiri_id": UserDefaults.standard.string(forKey:"current_user_id")], merge: true)
                                self.showCongrats.toggle()
                                
                            }
                            .font(.system(size: 18, weight: .bold, design: .default))
                            .foregroundColor(Color.gray)
                            .frame(width: 200, height: 50)
                            .background(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 20, style:.continuous))
                            .shadow(color:Color(#colorLiteral(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 1)) , radius: 10, x: 5, y: 5)
                            .shadow(color:Color(#colorLiteral(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 1)), radius: 10, x: -5, y: -5)
                            .navigationBarBackButtonHidden(true)
                            
                        }
                }
            }

    }
    
}

//struct P3_Congrats: View {
//    var transactionId = UserDefaults.standard.string(forKey:"transactionId")!
//    @State var didStartTrip = false
//    @State private var showHome = false
//
//    var body: some View{
//        if didStartTrip {
//            Deliver()
//        } else {
//
//            ZStack {
//                Color.blue.edgesIgnoringSafeArea(.all)
//                VStack{
//                    Text("Congratulations!")
//                        .padding(.top, 50)
//                        .font(.system(size: 21, weight: .medium, design: .default))
//                    Image("pashirin")
//                        .resizable()
//                        .aspectRatio(contentMode: .fit)
//                        .frame(width: 60, height: 60)
//                    Text("You have a Match!")
////                    HStack{
////                        Button(action: {
////                            print("Button Clicked")
////                        }) {
////
////                            Text("Chat Now")
////                                .foregroundColor(.white)
////                                .font(.title)
////                                .padding()
////                                .border(Color.white, width: 5)
////                        }
////                        NavigationView {
////                            NavigationLink(destination: Home()){
////                                Text("Chat juyjyu Now")
////                            }
////                        }
////                    }
//
//                    Button(action: {
//                        print(self.transactionId)
//                        Firestore.firestore().collection("transactions").document(self.transactionId).setData(["status": 3], merge: true)
//                        self.didStartTrip.toggle()
//
//                    }) {
//
//                        Text("Begin Trip")
//                            .foregroundColor(.white)
//                            .font(.title)
//                            .padding()
//                            .border(Color.white, width: 5)
//                    }
//
//                    Button (action: {
//                        self.showHome.toggle()
//                    }) {
//                        Text("Chat with Customer")
//                            .foregroundColor(.white)
//                            .font(.title)
//                            .padding()
//                            .border(Color.white, width: 5)
//                    }.sheet(isPresented: $showHome) {
//                        Home()
//                    }
//
//
//                }
//            }
//
//        }
//
//
//        //struct DetailView_Previews: PreviewProvider {
//        //    static var previews: some View {
//        //        DetailView(contact: contacts[0])
//        //            .padding(.top, 40)
//        //                }
//        //            }
//    }
//}

