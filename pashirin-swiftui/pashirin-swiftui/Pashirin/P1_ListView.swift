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
            List(viewModel.contacts) { contact in
                
                //                HStack{
                //                    Image("profile")
                //                        .resizable()
                //                        .frame(width: 60, height: 60)
                //                        .clipped()
                //                        .cornerRadius(50)
                //                    }
                NavigationLink(destination:P3_Interim (contact: contact).navigationBarBackButtonHidden(true)){
                    
                    VStack(alignment: .leading){
                        Text(contact.name)
                            .font(.system(size: 21, weight: .medium, design: .default))
                        Text("Offer Price: ¥\(contact.price)")
                            .font(.system(size: 21, weight: .medium, design: .default))
                        Text("Rating: \(contact.rating)")
                            .font(.subheadline)
                    }
                }
                .navigationBarTitle("PashiList")
                .navigationBarBackButtonHidden(true)

            }

            .onAppear(){
                self.viewModel.fetchData()
                print("onApearに入りました")
                UserDefaults.standard.set("67rCkmZExMNqquAJdCDShUfGF5f1", forKey: "current_user_id")
                print(UserDefaults.standard.string(forKey: "current_user_id")!)
            }
    }
}




struct P1_ListView_Previews: PreviewProvider {
    static var previews: some View {
        P1_ListView()
    }
}
