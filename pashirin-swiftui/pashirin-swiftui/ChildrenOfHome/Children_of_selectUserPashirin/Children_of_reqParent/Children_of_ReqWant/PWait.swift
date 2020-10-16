//
//  PWait.swift
//  reg_form
//
//  Created by Ryu Tamura on 2020/10/13.
//

import SwiftUI
import Firebase

struct PWait: View {
//    @Binding var transactionId: String
//    @Binding var isRequestGot: Bool
//    @Binding var status: Int
    @ObservedObject var waiting = WaitingViewModel()
    var body: some View {
        ZStack {
            Color(red: 0.00, green: 0.42, blue: 0.44).edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            HStack {
                Text("waiting for \n pashiri...")
                    .font(.system(size: 30))
                    .multilineTextAlignment(.center)
                    .padding(30)
                    .background(Color.white)
                    .cornerRadius(10)
            }
        }
    }
}


//struct PWait_Previews: PreviewProvider {
//    static var previews: some View {
//        PWait(true)
//    }
//}
