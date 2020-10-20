//
//  U2_ReqWant.swift
//  reg_form
//
//  Created by Ryu Tamura on 2020/10/12.
//

import SwiftUI
import Firebase
import FirebaseFirestore


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
    //@Binding var transactionId: String
//    @Binding var showWaitForP: Bool
//    @Binding var status: Int
    init() {
        UserDefaults.standard.set("1PdqjXKUVKh43EKrMGyA7zA15BK2",forKey:"current_user_id")
//        UserDefaults.standard.set("1PdqjXKUVKh43EKrMGyA7zA15BK2",forKey:"current_user_id")
//        UserDefaults.standard.set("1PdqjXKUVKh43EKrMGyA7zA15BK2",forKey:"current_user_id")
    }
    
    var body: some View {
        if UserDefaults.standard.string(forKey: "transactionId") == nil {
            ZStack {
//               Image("U1_background")
                Color(red: 6/255, green: 91/255, blue: 148/255)
                    .edgesIgnoringSafeArea(.all)
//                .offset(y: -100)
                ScrollView(.vertical) {
                    VStack(alignment: .center, spacing: 15) {
                        Group {
                            Text("What would you like to ask?")
                                .foregroundColor(.white)
                                .font(.system(size: 25))
                                .padding(.top, 20)
                            TextField("", text: $what)
                                .padding(.vertical, 30)
                                .padding(.leading, 10)
                                .background(Color.white)
                                .cornerRadius(15)
                                .foregroundColor(Color.black)
                                .padding(.horizontal, 40)
                                .frame(width: 380, height: 80, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            Spacer()
                            
                            
                            Text("Where is the place?")
                                .foregroundColor(.white)
                                .font(.system(size: 25))
                            TextField("", text: $whereTo)
                                .padding(10)
                                .background(Color.white)
                                .cornerRadius(15)
                                .foregroundColor(Color.black)
                                .padding(.horizontal, 40)
                                .frame(width: 380, height: 40, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            Spacer()
                            
                            Text("Where to bring?")
                                .foregroundColor(.white)
                                .font(.system(size: 25))
                            TextField("", text: $whereIs)
                                .padding(10)
                                .background(Color.white)
                                .cornerRadius(15)
                                .foregroundColor(Color.black)
                                .padding(.horizontal, 40)
                                .frame(width: 380, height: 40, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            Spacer()
                        }
                        Group {
                            Text("More details")
                                .foregroundColor(.white)
                                .font(.system(size: 25))
                            TextField("", text: $moreInfo)
                                .padding(.vertical, 30)
                                .padding(.leading, 10)
                                .background(Color.white)
                                .cornerRadius(15)
                                .foregroundColor(Color.black)
                                .padding(.horizontal, 40)
                                .frame(width: 380, height: 80, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            Spacer()
                            
                            Text("How much?")
                                .foregroundColor(.white)
                                .font(.system(size: 25))
                            TextField("", text: $price)
                                .padding(10)
                                .background(Color.white)
                                .cornerRadius(15)
                                .foregroundColor(Color.black)
                                .padding(.horizontal, 40)
                                .frame(width: 380, height: 40, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                .keyboardType(.decimalPad)
                            Spacer()
                            
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
                                
                                Image(systemName: "checkmark")
                                Text("Confirm")
                                    .fontWeight(.bold)
                                
                            }
                            .background(Color(red: 6/255, green: 91/255, blue: 158/255))
                            .padding(20)
                            .foregroundColor(Color.white)
//                            .font(.system(size: 18))
                            .cornerRadius(20)
                            .frame(width: 275, height: 50)
                            .alert(isPresented: $confirm, content: {
                                if self.isError {
                                    return Alert(title: Text(""), message: Text(self.errorMessage), dismissButton: .destructive(Text("OK")))
                                } else {
                                    return Alert(title: Text("Awesome! We'll start looking for a Pashiri!"), dismissButton: .default(Text("OK")))
                                }
                            })
                        }
                    }
                }.KeyboardResponsive()
            }
            
        } else {
            AfterRequest()
        }
        
    }
    
    func postTask() {
        let taskInfo = [
            "status": 1,
            "item": self.what,
            "startlocation": self.whereIs,
            "destination": self.whereTo,
            "detail": self.moreInfo,
            "price": Int(self.price) ?? 0,
            "user_id": UserDefaults.standard.string(forKey:"current_user_id")
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
}


//struct ReqWant_Previews: PreviewProvider {
//    @State static var staticShowWaitForP = true
//    
//    static var previews: some View {
//        ReqWant(showWaitForP: $staticShowWaitForP)
//    }
//}

