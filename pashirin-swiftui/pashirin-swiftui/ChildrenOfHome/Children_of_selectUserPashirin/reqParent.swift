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
        
        ReqWant_and_AfterRequest()
            
        
        
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
