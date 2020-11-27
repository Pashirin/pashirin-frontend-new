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
import Stripe

struct ReqWant_and_AfterRequest: View {
    @State private var what = ""
    @State private var whereIs = ""
    @State private var whereTo = ""
    @State private var moreInfo = ""
    @State private var price = ""
    @State private var now = Date()
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
    
    //Stripe Payment related variable
    @ObservedObject var paymentContextDelegate = PaymentContextDelegate()
    let config = STPPaymentConfiguration.shared()
    @State private var paymentContext: STPPaymentContext!
    @State var showAlert = false
    @State private var isPayed = false
    
    //        private let stripeCreditCartCut = 0.029
    //        private let flatFeeCents = 30
    //        var subtotal: Int {
    //            var amount = 0
    //            let priceToPennies = Int(price * 100)
    //            amount += priceToPennies
    //            return amount
    //        }
    //        var processingFees: Int {
    //            if subtotal == 0 {
    //                return 0
    //            }
    //            let sub = Double(subtotal)
    //            let feesAndSubtotal = Int(sub * stripeCreditCartCut) + flatFeeCents
    //            return feesAndSubtotal
    //        }
    //        var total: Int {
    //            return subtotal + processingFees
    //        }
    
    var body: some View {
        if UserDefaults.standard.string(forKey: "transactionId") == nil {
            ZStack{
                Color(red: 9/255, green: 91/255, blue: 148/255)
                    .edgesIgnoringSafeArea(.all)
                
                ScrollView(.vertical) {
                    LottieView(filename: "notfound")
                        .frame(width: 200, height: 200)
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
                            TextField("Ginza Matsuya", text: $whereIs)
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
                            TextField("1-1-1 Azabu, Roppongi", text: $whereTo)
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
                            TextField("bring until 8pm", text: $moreInfo)
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
                        
                        if !self.isPayed {
                            Button(action: {
                                self.confirm.toggle()
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
                                    self.isPayed.toggle()
                                    self.paymentContext.presentPaymentOptionsViewController()
                                }
                            }) {                            
                                Text(self.paymentContextDelegate.paymentMethodButtonTitle)
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
                                    return Alert(title: Text("Thank You!"),message:Text("The card will be charged once you are matched with a Pashirin"), dismissButton: .default(Text("OK")))
                                }
                            })
                        }
                        
                        
                        if self.isPayed {
                            Button(action: {
                                //Toggle submit button
                                self.confirm.toggle()
                                //Error message handle for each item
                                self.errorMessage = ""
                                //                                print("\(self.confirm)")
                                //                                print("This is me! at line 192")
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
                                    self.showAlert.toggle()
                                    self.status = 1
                                    
                                    
                                    //self.showWaitForP.toggle()
                                    
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
                                    return Alert(title: Text("Thank You!"),message:Text("The card will be charged once you are matched with a Pashirin"), dismissButton: .default(Text("OK"), action: {
                                        print("this is line 236")
                                        //Toggle showAlert
                                        self.showAlert.toggle()
                                        self.status = 1
                                    }))
                                }
                            })
                        }
                        //                        .background(Color.white)
                        //                        .edgesIgnoringSafeArea(.all)
                        //                        .clipShape(RoundedRectangle(cornerRadius: 15, style:.continuous))
                        //                        .shadow(color:Color.black.opacity(0.25),  radius: 5,  y: 3)
                        //                        .padding(.bottom,20)
                        
                    }
                    .onAppear {
                        self.paymentContextConfiguration()
                    }
                    //                    .alert(isPresented: self.$paymentContextDelegate.showAlert) {
                    //                        Alert(title: Text(""), message: Text(self.paymentContextDelegate.message), dismissButton: .default(Text("OK")))
                    //
                    //                    }
                    //                    .alert(isPresented: $showAlert, content: {self.alert})
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
    //    var alert: Alert {
    //        Alert(title: Text("Thank You!"),message:Text("The card will be charged once you are matched with a Pashirin")
    //        )}
    
    
    func postTask() {
        //Converting date format to string
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d y, HH:mm E"
        let date = formatter.string(from: self.now)
        
        //Putting data into an array
        let taskInfo = [
            "status": 1,
            "item": self.what,
            "startlocation": self.whereIs,
            "destination": self.whereTo,
            "detail": self.moreInfo,
            "price": Int(self.price) ?? 0,
            "user_id": UserDefaults.standard.string(forKey:"current_user_id") ?? "No namaken ID",
            "timestamp": date
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
    
    func paymentContextConfiguration() {
        let customerContext = STPCustomerContext(keyProvider: MyAPIClient())
        // self.config.shippingType = .shipping
        self.config.requiredBillingAddressFields = .full
        
        // self.config.requiredShippingAddressFields = [.postalAddress, .emailAddress]
        
        //self.config.companyName = "Testing"
        
        self.paymentContext = STPPaymentContext(customerContext: customerContext, configuration: self.config, theme: .default())
        
        self.paymentContext.delegate = self.paymentContextDelegate
        
        let keyWindow = UIApplication.shared.connectedScenes
            .filter({$0.activationState == .foregroundActive})
            .map({$0 as? UIWindowScene})
            .compactMap({$0})
            .first?.windows
            .filter({$0.isKeyWindow}).first
        
        self.paymentContext.hostViewController = keyWindow?.rootViewController
        //        self.paymentContext.paymentAmount = self.total
        
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

