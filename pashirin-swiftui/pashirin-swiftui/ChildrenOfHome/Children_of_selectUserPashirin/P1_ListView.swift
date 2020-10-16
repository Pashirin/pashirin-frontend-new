//
//  ContentView.swift
//  dataFetch
//
//  Created by Eri Koyano on 2020/10/12.
//

import SwiftUI


struct P1_ListView: View {
    
@ObservedObject private var viewModel = ContactsViewModel()
    
    var body: some View {
        //NavigationView{
            List(viewModel.contacts) { contact in
               
                HStack{
                    Image("profile")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .clipped()
                        .cornerRadius(50)
                    }
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
                }
            }
       // }
    }




struct P1_ListView_Previews: PreviewProvider {
    static var previews: some View {
        P1_ListView()
    }
}
