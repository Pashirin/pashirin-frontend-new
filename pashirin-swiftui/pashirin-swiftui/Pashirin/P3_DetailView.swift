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
            
                    VStack(){
                        LottieView(filename: "Airplane")
                            .frame(width: 300, height: 300,alignment: .center)
                        

                        VStack(spacing: 20){
                            List{
                                HStack{
                                    Image(systemName: "yensign.square")
                                        .frame(width: 20, height: 20,alignment: .center)
                                        .font(.system(size: 25))
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
                                        .font(.system(size: 25))
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
                                        .font(.system(size: 25))
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
                                        .font(.system(size: 25))
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
                            .clipShape(RoundedRectangle(cornerRadius: 10, style:.continuous))
                            .shadow(color:Color.black.opacity(0.25),  radius: 5, x: 3, y: 3)
                            .padding(20)
                        
                        
                        
                        
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
                                .shadow(color:Color.black.opacity(0.25),  radius: 5, x: 3, y: 3)
                                .navigationBarBackButtonHidden(true)
                                
                            }
                        }
                        .padding(100)
                        .background(Color(red: 254/255, green: 163/255, blue: 93/255))
                    }
            }

    }
    
}


