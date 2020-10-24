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
            VStack{
                Color(red: 9/255, green: 91/255, blue: 148/255)
                .frame(width: 1000, height: 300)
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0,maxHeight: .infinity,alignment: .topLeading)
            .edgesIgnoringSafeArea(.top)

            Image("shelf-2")
                .offset(y: -100)
               
        
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
