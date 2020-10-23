//
//  PWait.swift
//  reg_form
//
//  Created by Ryu Tamura on 2020/10/13.
//

import SwiftUI
import Firebase
import Lottie


struct PWait: View {
//    @Binding var transactionId: String
//    @Binding var isRequestGot: Bool
//    @Binding var status: Int
   
    @ObservedObject var waiting = WaitingViewModel()
    var body: some View {
        ZStack {
            
            Image("watingBackground")
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                .offset(y: -172) // この微調整ができない
            Image("watingLogo")
                .offset(y: -100)
            Image("userIcon")
                .offset(x: 130,y: -350)
            HStack {
                Text("WAITING FOR \n PASHIRIN...")
                    .foregroundColor(Color(red: 101/255, green: 101/255, blue: 101/255))
                    .fontWeight(.bold)
                    .font(.system(size: 24))
                    .multilineTextAlignment(.center)
            }
        }
//        .navigationBarBackButtonHidden(true)
    }
}


//struct PWait_Previews: PreviewProvider {
//    static var previews: some View {
//        PWait(true)
//    }
//}
