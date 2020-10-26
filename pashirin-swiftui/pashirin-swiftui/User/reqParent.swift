//
//  reqParent.swift
//  reg_form
//
//  Created by Ryu Tamura on 2020/10/13.
//

import SwiftUI

struct reqParent: View {
    @State private var transactionId = ""
    @State private var showWaitForP = false
    @ObservedObject var statusViewModel = StatusViewModel()
    //@ObservedObject var waitingViewModel = WaitingViewModel()
    //
    @State private var isRequestGot = false
    @State var status = 0;
    //@State private var requestStatus = WaitingViewModel() //UserDefaults.standard.value(forKey: "requestStatus")
    
    var body: some View {
        
        //もし取引statusが1(リクエストのみ）の場合PWaitviewに移動
        TabView{
            //Request page
            ReqWant_and_AfterRequest()
                .tabItem{
                    Image(systemName: "figure.walk")
                        
                        .font(.system(size: 40))
                        .foregroundColor(Color.gray)
                    Text("Request")
                        .font(.system(size: 15))
                        .foregroundColor(Color.gray)
                    
                }
            
            UserHistory()
                .tabItem{
                    Image(systemName: "clock")
                        
                        .font(.system(size: 40))
                        .foregroundColor(Color.gray)
                    
                    Text("History")
                        .font(.system(size: 15))
                        .foregroundColor(Color.gray)
                }
            
            AccountDetail()
                .tabItem{
                    Image(systemName: "person.fill")
                        
                        .font(.system(size: 40))
                        .foregroundColor(Color.gray)
                    
                    Text("Account")
                        .font(.system(size: 15))
                        .foregroundColor(Color.gray)
                }
        }
        .navigationBarBackButtonHidden(true)
        .font(.headline)
        // chage color when tap button
        .accentColor(Color(red: 254/255, green: 139/255, blue: 93/255))
        // make background white
        .onAppear() {
            UITabBar.appearance().barTintColor = .white
        }
        
        
        
        //        if self.waitingViewModel.status == 2 {
        //            U4_Matched()
        //        } else if self.showWaitForP {
        //            PWait(transactionId: $transactionId, isRequestGot: $isRequestGot)
        //        } else  {
        //            ReqWant(transactionId: $transactionId, showWaitForP: $showWaitForP)
        //        }
    }
}

struct reqParent_Previews: PreviewProvider {
    static var previews: some View {
        reqParent()
    }
}
