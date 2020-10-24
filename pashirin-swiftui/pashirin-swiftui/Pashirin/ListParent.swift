//
//  ListParent.swift
//  pashirin-swiftui
//
//  Created by Ryu Tamura on 2020/10/24.
//  Copyright © 2020 HONGHYONGGUK. All rights reserved.
//

import SwiftUI

struct ListParent: View {
    var body: some View {
        TabView {
            P1_ListView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                        
                        .font(.system(size: 40))
                        .foregroundColor(Color.gray)
                    Text("Request")
                        .font(.system(size: 15))
                        .foregroundColor(Color.gray)
                }
            
            PashirinHistory()
                .tabItem{
                    Image(systemName: "clock")
                        
                        .font(.system(size: 40))
                        .foregroundColor(Color.gray)
                    
                    Text("History")
                        .font(.system(size: 15))
                        .foregroundColor(Color.gray)
                }
            
            AccountDetail()
                .tabItem{
                    Image(systemName: "person.fill")
                        
                        .font(.system(size: 40))
                        .foregroundColor(Color.gray)
                    
                    Text("Account")
                        .font(.system(size: 15))
                        .foregroundColor(Color.gray)
                }
        }
        .font(.headline)
        // chage color when tap button
        .accentColor(Color(red: 254/255, green: 139/255, blue: 93/255))
        // make background white
        .onAppear() {
            UITabBar.appearance().barTintColor = .white
        }
    }
}

struct ListParent_Previews: PreviewProvider {
    static var previews: some View {
        ListParent()
    }
}
