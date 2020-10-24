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
            ZStack{
                VStack{
                    Color(red: 9/255, green: 91/255, blue: 148/255)
                    .frame(width: 1000, height: 500)
                }
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0,maxHeight: .infinity,alignment: .topLeading)
                .edgesIgnoringSafeArea(.top)

           
            
                ScrollView(.vertical) {
                    VStack(alignment: .center, spacing: 30) {
//                        Image("order")
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
                                .clipShape(RoundedRectangle(cornerRadius: 20, style:.continuous))
                                .shadow(color:Color(#colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)) , radius: 3, x: 3, y: 3)
                            
                            
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
                                .clipShape(RoundedRectangle(cornerRadius: 20, style:.continuous))
                                .shadow(color:Color(#colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)) , radius: 3, x: 3, y: 3)
                            
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
                                .clipShape(RoundedRectangle(cornerRadius: 20, style:.continuous))
                                .shadow(color:Color(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)) , radius: 3, x: 0, y: 3)
                            
                        }
                        
                        
                        VStack(alignment:.leading,spacing: 10){
                            Text("More details")
                                
                                .foregroundColor(.gray)
                                .font(.system(size: 18))
                            //                                .padding(EdgeInsets(top: 0, leading: 0, bottom: 5, trailing: 0))
                            TextField("bring untill 8pm", text: $moreInfo)
                                .padding(.vertical, 30)
                                .padding(.leading, 10)
                                .background(Color.white)
                                .cornerRadius(20)
                                .foregroundColor(Color.black)
                                .frame(width: 327, height: 58)
                                .clipShape(RoundedRectangle(cornerRadius: 20, style:.continuous))
                                .shadow(color:Color(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)) , radius: 3, x: 3, y: 3)
                            
                            
                        }
                        
                        
                        VStack(alignment:.leading,spacing: 10){
                            Text("How much?")
                                .foregroundColor(.gray)
                                .font(.system(size: 18))
                            TextField("1000", text: $price)
                                .padding(.vertical, 30)
                                .padding(.leading, 10)
                                .background(Color.white)
                                .cornerRadius(20)
                                .foregroundColor(Color.black)
                                .frame(width: 327, height: 58)
                                .clipShape(RoundedRectangle(cornerRadius: 20, style:.continuous))
                                .shadow(color:Color(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)) , radius: 3, x: 3, y: 3)
                                
                                .keyboardType(.decimalPad)
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
                            HStack{
                                Image(systemName: "checkmark")
                                Text("Confirm")
                                    .fontWeight(.bold)
                                    .font(.system(size: 16))
                            }
                            .foregroundColor(Color.white)
                            .frame(width: 275, height: 50)
                            .background(Color(red: 6/255, green: 91/255, blue: 148/255))
                            .clipShape(RoundedRectangle(cornerRadius: 20, style:.continuous))
                            .shadow(color:Color(red: 217/255, green: 217/255, blue: 217/255) , radius: 10, x: 5, y: 5)
                            .shadow(color:Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)), radius: 10, x: -5, y: -5)
                        }
                        .background(Color.white)
                        .edgesIgnoringSafeArea(.all)
                        
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
//            .navigationBarBackButtonHidden(true)
            
//                .KeyboardResponsive()

            
            
        } else {
            AfterRequest()
//                .navigationBarBackButtonHidden(true)
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

