//
//  ContentView.swift
//  dataFetch
//
//  Created by Eri Koyano on 2020/10/12.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseAuth


struct P1_ListView: View {
    
    @ObservedObject private var viewModel = ContactsViewModel()
    @State private var userId = ""
    //後で消す
    
    var body: some View {
        ZStack{
            Color(red: 254/255, green: 163/255, blue: 93/255).edgesIgnoringSafeArea(.all)
            VStack(spacing: 10){
                LottieView(filename: "light")
                        .frame(width: 250, height: 250)
                VStack(spacing: 10){
                    List(viewModel.contacts) { contact in
                        
                        NavigationLink(destination:P3_Interim (contact: contact).navigationBarBackButtonHidden(true)){
                            
                            VStack(alignment: .leading){
                                Text("Offer Price: ¥\(contact.price)")
                                    .font(.system(size: 21, weight: .medium, design: .default))
                                Text("Destination: \(contact.destination)")
                                    .font(.system(size: 18))
                                    .foregroundColor(.gray)
                            }.padding(10)
                        }
                        .navigationBarTitle("PashiList")
                        .navigationBarBackButtonHidden(true)

                    }
                    .onAppear(){
                        self.viewModel.fetchData()
                        print("onAppearに入りました")
                        getUserId()
                        UserDefaults.standard.set(self.userId, forKey: "current_user_id")
                        print(UserDefaults.standard.string(forKey: "current_user_id")!)
                    }
                    
                }
                .frame(width: 350, height: 400, alignment: .top)
                .clipShape(RoundedRectangle(cornerRadius: 15, style:.continuous))
                .shadow(color:Color.black.opacity(0.25),  radius: 5, x: 3, y: 3)
            }
            .frame(minWidth: 0,maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
            .edgesIgnoringSafeArea(.top)
        }
       
        
        
    }
    
    func getUserId() {
        var db: Firestore!
        // [START setup]
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        // [END setup]
        db = Firestore.firestore()
        // Get current login user uid and email
        self.userId = Auth.auth().currentUser?.uid ?? "no User ID"
        print("Pashirin UID is \(self.userId)")
    }
    
}




struct P1_ListView_Previews: PreviewProvider {
    static var previews: some View {
        P1_ListView()
    }
}
