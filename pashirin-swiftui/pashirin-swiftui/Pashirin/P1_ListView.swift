//
//  ContentView.swift
//  dataFetch
//
//  Created by Eri Koyano on 2020/10/12.
//

import SwiftUI


struct P1_ListView: View {
    
    @ObservedObject private var viewModel = ContactsViewModel()
    //後で消す
    
    var body: some View {
            TabView{
                    List(viewModel.contacts) { contact in
                    NavigationLink(destination:P3_DetailView (contact: contact)){
                        
                        VStack(alignment: .leading){
                            Text(contact.name)
                                .font(.system(size: 21, weight: .medium, design: .default))
                            Text("Offer Price: ¥\(contact.price)")
                                .font(.system(size: 21, weight: .medium, design: .default))
                            Text("Rating: \(contact.rating)")
                                .font(.subheadline)
                        }
                     }
                  }
                    .navigationBarTitle("PashiList")
                    .onAppear(){
                        self.viewModel.fetchData()
                        print("onApearに入りました")
                        UserDefaults.standard.set("67rCkmZExMNqquAJdCDShUfGF5f1", forKey: "current_user_id")
                        print(UserDefaults.standard.string(forKey: "current_user_id")!)
                        }
                    
                    .tabItem {
                        Image(systemName: "magnifyingglass")
            
                            .font(.system(size: 40))
                            .foregroundColor(Color.gray)
                        Text("Request")
                            .font(.system(size: 15))
                            .foregroundColor(Color.gray)
                    }
                
                Text("Detail")
                    .tabItem{
                    Image(systemName: "cart.fill")
                        
                        .font(.system(size: 38))
                        .foregroundColor(Color.gray)
                    Text("Detail")
                        .font(.system(size:15))
                        .foregroundColor(Color.gray)
                    
                }
            
                Text("History")
                    .tabItem{
                    Image(systemName: "clock")
                    
                        .font(.system(size: 40))
                        .foregroundColor(Color.gray)
                        
                    Text("History")
                        .font(.system(size: 15))
                        .foregroundColor(Color.gray)
                }
                
            
                Text("Account Detail")
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




struct P1_ListView_Previews: PreviewProvider {
    static var previews: some View {
        P1_ListView()
    }
}
