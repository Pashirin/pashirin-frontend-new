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
                        .shadow(color:Color.black.opacity(0.25),  radius: 5, x: 3, y: 3)
                        
                    }
                    .navigationBarBackButtonHidden(true)
                    .background(Color.white)
                                        
                
                    
                    NavigationLink(destination: ListParent()){
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
                        .shadow(color:Color.black.opacity(0.25),  radius: 5, x: 3, y: 3)

                        
                    }
                    .background(Color.white)
                    .edgesIgnoringSafeArea(.top)
                }
                .frame(minWidth: 0,  maxWidth: .infinity, minHeight:0,  maxHeight: .infinity, alignment: .center)
                .edgesIgnoringSafeArea(.top)

            }

    }
}
//}


