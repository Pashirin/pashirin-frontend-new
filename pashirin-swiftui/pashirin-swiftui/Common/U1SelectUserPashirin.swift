//
//  User:Pashirin.swift
//  PASHIRIN
//
//  Created by あっき on 2020/10/10.
//

import Foundation
import SwiftUI
import FirebaseAuth
import FirebaseFirestore

// When login , Change user / Pashirin to form database?



struct UserPashirin : View{
    
    var body : some View {
        NavigationView{
                VStack(alignment: .center, spacing: 50) {
                    NavigationLink(destination: reqParent()){
                        VStack{
                            Text("namaken")
                                .fontWeight(.bold)
                                .font(.system(size: 21))
                                .foregroundColor(/*@START_MENU_TOKEN@*/.gray/*@END_MENU_TOKEN@*/)
                            Image("namaken")
                            
                        }
                        .frame(width: 180, height: 150)
                        .background(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 20, style:.continuous))
                        .shadow(color:Color(#colorLiteral(red: 0.8873181228, green: 0.8873181228, blue: 0.8873181228, alpha: 1)) , radius: 7, x: 4, y: 4)
                        .shadow(color:Color(#colorLiteral(red: 0.8873181228, green: 0.8873181228, blue: 0.8873181228, alpha: 1)), radius: 7, x: -5, y: -5)
                        
                    }
//                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.white)
                    .edgesIgnoringSafeArea(.all)
                                        
                
                    
                    NavigationLink(destination: P1_ListView()){
                        VStack{
                            Text("pashirin")
                                .fontWeight(.bold)
                                .font(.system(size: 21))
                                .foregroundColor(/*@START_MENU_TOKEN@*/.gray/*@END_MENU_TOKEN@*/)
                                .padding(EdgeInsets(top: 0, leading: 0, bottom: 5, trailing: 0))
                        
                            Image(systemName: "figure.walk")
                                .foregroundColor(Color(red: 254/255, green: 139/255, blue: 93/255))
                                .font(.system(size: 40))
                        }
                        .frame(width: 180, height: 150)
                        .background(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 20, style:.continuous))
                        .shadow(color:Color(#colorLiteral(red: 0.8873181228, green: 0.8873181228, blue: 0.8873181228, alpha: 1)) , radius: 7, x: 4, y: 4)
                        .shadow(color:Color(#colorLiteral(red: 0.8873181228, green: 0.8873181228, blue: 0.8873181228, alpha: 1)), radius: 7, x: -5, y: -5)

                        
                    }
                    .background(Color.white)
                    .edgesIgnoringSafeArea(.all)
                }
//                .onAppear {
//
//                    let domain = Bundle.main.bundleIdentifier!
//                    UserDefaults.standard.removePersistentDomain(forName: domain)
//                    UserDefaults.standard.synchronize()
//                    UserDefaults.standard.set("タダモン", forKey: "name")
//
//                }
            }
        .edgesIgnoringSafeArea(.all)

    }
}
//}


