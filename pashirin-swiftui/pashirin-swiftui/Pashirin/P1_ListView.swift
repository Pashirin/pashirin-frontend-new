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
        VStack{
            LottieView(filename: "Shape")
                    .frame(width: 200, height: 200)
            VStack{
                List(viewModel.contacts) { contact in
                    
                    NavigationLink(destination:P3_Interim (contact: contact).navigationBarBackButtonHidden(true)){
                        
                        VStack(alignment: .leading){
                            Text("Offer Price: ¥\(contact.price)")
                                .font(.system(size: 21, weight: .medium, design: .default))
                            Text("Destination: \(contact.destination)")
                                .font(.system(size: 18))
                                .foregroundColor(.gray)
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
                }
                
            }
            .frame(width: 350, height: 400, alignment: .bottom)
            .background(Color(red: 254/255, green: 163/255, blue: 93/255))
            .clipShape(RoundedRectangle(cornerRadius: 10, style:.continuous))
            .shadow(color:Color.black.opacity(0.25),  radius: 5, x: 3, y: 3)
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
