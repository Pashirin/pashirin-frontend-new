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
            ScrollView{
                VStack {
                    NavigationLink(destination: reqParent()){
                        Text("USER")
                    }
                    
                    .frame(width: 100, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).foregroundColor(/*@START_MENU_TOKEN@*/.gray/*@END_MENU_TOKEN@*/)
                    
                    NavigationLink(destination: P1_ListView()){
                        Text("PAHIRI")
                    }
                    .frame(width: 100, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).foregroundColor(/*@START_MENU_TOKEN@*/.gray/*@END_MENU_TOKEN@*/)
                }
                .onAppear {
                    
                    let domain = Bundle.main.bundleIdentifier!
                    UserDefaults.standard.removePersistentDomain(forName: domain)
                    UserDefaults.standard.synchronize()
                    UserDefaults.standard.set("タダモン", forKey: "name")
                    
                }
            }
        }
        
        
    }
}


