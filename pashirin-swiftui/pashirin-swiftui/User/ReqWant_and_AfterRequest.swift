//
//  U2_ReqWant.swift
//  reg_form
//
//  Created by Ryu Tamura on 2020/10/12.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseAuth
import CoreLocation

struct ReqWant_and_AfterRequest: View {
    @State private var what = ""
    @State private var whereIs = ""
    @State private var whereTo = ""
    @State private var moreInfo = ""
    @State private var price = ""
    @State private var confirm = false
    @State private var isShowAlert = false
    @State private var isError = false
    @State private var errorMessage = ""
    @State private var status: Int = 1
    @State private var userId = ""
    @State var location = ""
    @State var StartLocation = ""
    //@Binding var transactionId: String
//    @Binding var showWaitForP: Bool
//    @Binding var status: Int
//    init() {
//        getUserId()
//        UserDefaults.standard.set(self.userId, forKey:"current_user_id")
//    }
    
    var body: some View {
        if UserDefaults.standard.string(forKey: "transactionId") == nil {
            ZStack{
                    Color(red: 9/255, green: 91/255, blue: 148/255)
                        .edgesIgnoringSafeArea(.all)
                
                ScrollView(.vertical) {
                    LottieView(filename: "notfound")
                        .frame(width: 200, height: 200)
                    VStack(alignment: .center, spacing: 30) {
                        VStack(alignment: .leading,spacing: 10){
                            Text("What would you like to ask?")
                                .foregroundColor(.white)
                                .font(.system(size: 18))
                                .padding(EdgeInsets(top: 0, leading: 0, bottom: 5, trailing: 0))
                            TextField("Beer, Snack", text: $what)
                                .padding(.vertical, 30)
                                .padding(.leading, 10)
                                .background(Color.white)
                                .cornerRadius(20)
                                .foregroundColor(Color.black)
                                .frame(width: 327, height: 58)
                                .clipShape(RoundedRectangle(cornerRadius: 15, style:.continuous))
                                .shadow(color:Color.black.opacity(0.25),  radius: 2, y: 3)
                            Text("*require")
                                .font(.system(size: 12))
                                .foregroundColor(Color(red: 254/255, green: 163/255, blue: 93/255))
                            
                        }
                        
                        
                        
                        
                        VStack(alignment: .leading,spacing: 10){
                            Text("Where can I find?")
                                .foregroundColor(.white)
                                .font(.system(size: 18))
                            TextField("Ginza Matsuya", text: $whereTo)
                                .padding(.vertical, 30)
                                .padding(.leading, 10)
                                .background(Color.white)
                                .cornerRadius(20)
                                .foregroundColor(Color.black)
                                .frame(width: 327, height: 58)
                                .clipShape(RoundedRectangle(cornerRadius: 15, style:.continuous))
                                .shadow(color:Color.black.opacity(0.25),  radius: 2, y: 3)
                            Text("*require")
                                .font(.system(size: 12))
                                .foregroundColor(Color(red: 254/255, green: 163/255, blue: 93/255))
                        }
                        
                        
                        VStack(alignment: .leading,spacing: 10){
                            Text("Where to bring?")
                                
                                .foregroundColor(.white)
                                .font(.system(size: 18))
                            TextField("1-1-1 Azabu, Roppongi", text: $whereIs)
                                .padding(.vertical, 30)
                                .padding(.leading, 10)
                                .background(Color.white)
                                .cornerRadius(20)
                                .foregroundColor(Color.black)
                                .frame(width: 327, height: 58)
                                .clipShape(RoundedRectangle(cornerRadius: 15, style:.continuous))
                                .shadow(color:Color.black.opacity(0.25),  radius: 2, y: 3)
                            Text("*require")
                                .font(.system(size: 12))
                                .foregroundColor(Color(red: 254/255, green: 163/255, blue: 93/255))
                        }
                        
                        
                        VStack(alignment:.leading,spacing: 10){
                            Text("More details")
                                
                                .foregroundColor(.white)
                                .font(.system(size: 18))
                            //                                .padding(EdgeInsets(top: 0, leading: 0, bottom: 5, trailing: 0))
                            TextField("bring untill 8pm", text: $moreInfo)
                                .padding(.vertical, 30)
                                .padding(.leading, 10)
                                .background(Color.white)
                                .cornerRadius(20)
                                .foregroundColor(Color.black)
                                .frame(width: 327, height: 58)
                                .clipShape(RoundedRectangle(cornerRadius: 15, style:.continuous))
                                .shadow(color:Color.black.opacity(0.25),  radius: 2, y: 3)
                            
                            
                        }
                        
                        
                        VStack(alignment:.leading,spacing: 10){
                            Text("How much?")
                                .foregroundColor(.white)
                                .font(.system(size: 18))
                            TextField("1000", text: $price)
                                .padding(.vertical, 30)
                                .padding(.leading, 10)
                                .background(Color.white)
                                .cornerRadius(20)
                                .foregroundColor(Color.black)
                                .frame(width: 327, height: 58)
                                .clipShape(RoundedRectangle(cornerRadius: 15, style:.continuous))
                                .shadow(color:Color.black.opacity(0.25),  radius: 2, y: 3)
                                
                                .keyboardType(.decimalPad)
                            Text("*require")
                                .font(.system(size: 12))
                                .foregroundColor(Color(red: 254/255, green: 163/255, blue: 93/255))
                        }
                        .padding(.bottom)
                        
                        
                        
                        Button(action: {
                            //Toggle submit button
                            self.confirm.toggle()
                            //Error message handle for each item
                            self.errorMessage = ""
                            if self.what.isEmpty {
                                self.errorMessage = "Please enter your request"
                                self.isError = true
                                self.isShowAlert = true
                            } else if self.whereTo.isEmpty {
                                self.errorMessage = "Please enter destination"
                                self.isError = true
                                self.isShowAlert = true
                            } else if self.price.isEmpty {
                                self.errorMessage = "Please enter your desired price"
                                self.isError = true
                                self.isShowAlert = true
                            } else {
                                self.postTask()
                                //self.showWaitForP.toggle()
                                self.status = 1
                            }
                        }) {
                
                                Text("Confirm")
                                    .fontWeight(.bold)
                                    .font(.system(size: 18))
                            
                            .foregroundColor(Color(red: 6/255, green: 91/255, blue: 148/255))
                            .frame(width: 200, height: 50)
                            .background(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 15, style:.continuous))
                            .shadow(color:Color.black.opacity(0.25),  radius: 5,  y: 3)
                            
                        }
                        .background(Color.white)
                        .edgesIgnoringSafeArea(.all)
                        .clipShape(RoundedRectangle(cornerRadius: 15, style:.continuous))
                        .shadow(color:Color.black.opacity(0.25),  radius: 5,  y: 3)
                        .padding(.bottom,20)
                        
                        .alert(isPresented: $confirm, content: {
                            if self.isError {
                                return Alert(title: Text(""), message: Text(self.errorMessage), dismissButton: .destructive(Text("OK")))
                            } else {
                                return Alert(title: Text("Awesome! We'll start looking for a Pashiri!"), dismissButton: .default(Text("OK")))
                            }
                        })
                    }
                }
                
            }
            .onAppear {
                getUserId()
                UserDefaults.standard.set(self.userId, forKey: "current_user_id")
                print(UserDefaults.standard.string(forKey: "current_user_id")!)
            }
            .onTapGesture {
                self.hideKeyboard()
            }
//            .navigationBarBackButtonHidden(true)
            
//                .KeyboardResponsive()

            
            
        } else {
            AfterRequest()
//                .navigationBarBackButtonHidden(true)
        }
        
    }
    
    func postTask() {
        //目的地と出発地点から座標を出す
//        CLGeocoder().geocodeAddressString(self.whereIs){ placemarks, error in
//            if let latitude = placemarks?.first?.location?.coordinate.latitude{
//                print("緯度は　", latitude )
//            }
//            if let longtitude = placemarks?.first?.location?.coordinate.longitude {               print("経度は　", longtitude )
//
//            }
//        }
        
        let taskInfo = [
            "status": 1,
            "item": self.what,
            "startlocation": self.whereIs,
            "destination": self.whereTo,
            "detail": self.moreInfo,
            "price": Int(self.price) ?? 0,
            "user_id": UserDefaults.standard.string(forKey:"current_user_id") ?? "No namaken ID"
        ] as [String : Any]

        //transactionIdを生成する
        let transactionId = UUID().uuidString
        //self.transactionId = transactionId
        UserDefaults.standard.set(transactionId, forKey: "transactionId")
        print("これが！！！！！", transactionId)
        let docRef = Firestore.firestore().document("transactions/\(transactionId)")
        print(docRef)
        print("setting transactions data")
        docRef.setData(taskInfo) { (error) in
            if let error = error {
                print("error = \(error)")
            } else {
                print("taskInfo uploaded successfully")
                //clearing form
                self.what = ""
                self.whereIs = ""
                self.whereTo = ""
                self.moreInfo = ""
                self.price = ""
            }
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
        print("Namaken UID is \(self.userId)")
    }
}

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif

//struct ReqWant_Previews: PreviewProvider {
//    @State static var staticShowWaitForP = true
//    
//    static var previews: some View {
//        ReqWant(showWaitForP: $staticShowWaitForP)
//    }
//}

