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
    let transactionId = UserDefaults.standard.string(forKey: "transactionId")
    let pashiri_id = UserDefaults.standard.string(forKey: "current_user_id")

    
    var body: some View {
            if showCongrats {
                ContainerForStatus()
            } else {
            
                    ZStack{
                        VStack{
                            Color(red: 254/255, green: 163/255, blue: 93/255)
                            .frame(width: 1000, height: 450)
                        }
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0,maxHeight: .infinity,alignment: .bottom)
                        .edgesIgnoringSafeArea(.bottom)
                        
                        VStack(spacing:50){
                            LottieView(filename: "Airplane")
                                .frame(width: 300, height: 300,alignment: .top)
                                .edgesIgnoringSafeArea(.top)
                            
                            VStack(spacing: 20){
                                List{
                                    HStack{
                                        Image(systemName: "yensign.square")
                                            .frame(width: 20, height: 20,alignment: .center)
                                            .font(.system(size: 30))
                                            .foregroundColor(.gray)
                                        Spacer()
                                        Text("¥\(contact.price)")
                                            .foregroundColor(Color(red: 111/255, green: 111/255, blue: 111/255))
                                            .fontWeight(.bold)
                                            .font(.system(size: 20))
                                            .onAppear {
                                                print("This is P3_DetailView and tID is \(String(describing: self.transactionId))")
                                            }
                                    }
                                    
                                    HStack{
                                        Image(systemName: "cart")
                                            .frame(width: 20, height: 20,alignment: .center)
                                            .font(.system(size: 30))
                                            .foregroundColor(.gray)
                                        Spacer()
                                        Text("\(contact.item)")
                                            .foregroundColor(Color(red: 111/255, green: 111/255, blue: 111/255))
                                            .fontWeight(.bold)
                                            .font(.system(size: 20))
                                    }
            
                    
                                    HStack{
                                        Image(systemName: "mappin")
                                            .frame(width: 20, height: 20,alignment: .center)
                                            .font(.system(size: 30))
                                            .foregroundColor(.gray)
                                        Spacer()
                                        Text(contact.startlocation)
                                            .foregroundColor(Color(red: 111/255, green: 111/255, blue: 111/255))
                                            .fontWeight(.bold)
                                            .font(.system(size:20))
                                    }
                                

                                    HStack{
                                        Image(systemName: "doc.text")
                                            .frame(width: 20, height: 20,alignment: .center)
                                            .font(.system(size: 30))
                                            .foregroundColor(.gray)
                                        Spacer()
                                        Text(contact.detail)
                                            .foregroundColor(Color(red: 111/255, green: 111/255, blue: 111/255))
                                            .fontWeight(.bold)
                                            .font(.system(size: 20))
                                    }
                                    
                                }
                                .frame(width: 300, height: 200,alignment: .center)
                                .background(Color.white)
                                .clipShape(RoundedRectangle(cornerRadius: 20, style:.continuous))
                                .shadow(color:Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)) , radius: 5, x: 3, y: 3)
                                .shadow(color:Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)), radius: 5, x: -3, y: -3)
                                
                            
                            
                            
                         
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
                                    .foregroundColor(Color(red: 111/255, green: 111/255, blue: 111/255))
                                    .frame(width: 200, height: 50)
                                    .background(Color.white)
                                    .clipShape(RoundedRectangle(cornerRadius: 20, style:.continuous))
//                                    .shadow(color:Color(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)) , radius: 5, x: 3, y: 3)
//                                    .shadow(color:Color(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)), radius: 5, x: -3, y: -3)
                                    .navigationBarBackButtonHidden(true)
                                    
                                }
                            }
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

