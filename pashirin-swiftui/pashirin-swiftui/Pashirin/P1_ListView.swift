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
    @State private var pashirinFirstName = ""
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
            NavigationLink(destination:P3_Interim (contact: contact, pashirinFirstName: $pashirinFirstName).navigationBarBackButtonHidden(true)){
                
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
            print("onAppearに入りました")
            getUserId()
            UserDefaults.standard.set(self.userId, forKey: "current_user_id")
            print(UserDefaults.standard.string(forKey: "current_user_id")!)
            getPashirinFirstName()
            print("Pashirin firstName is \(self.pashirinFirstName)")
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
    
    func getPashirinFirstName() {
        let db = Firestore.firestore()
        var _: Void = db.collection("users").document(self.userId).getDocument() { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data()
                // document.data --> [fistname:"name", lastname : "lastname"] Object with String
                // Cheking type as String
                if let firstname = dataDescription?["firstName"] as? String {
                    self.pashirinFirstName = firstname
                    print("this is \(self.pashirinFirstName)")
                }
                else {
                    print("This not string.")
                }
            } else {
                print("Document does not exist")
            }
        }
    }
    
}




struct P1_ListView_Previews: PreviewProvider {
    static var previews: some View {
        P1_ListView()
    }
}

