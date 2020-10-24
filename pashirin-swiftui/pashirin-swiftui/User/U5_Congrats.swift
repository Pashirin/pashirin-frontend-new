//
//  U5_Congrats.swift
//  pashirin-swiftui
//
//  Created by あっき on 2020/10/20.
//  Copyright © 2020 HONGHYONGGUK. All rights reserved.
//

import SwiftUI
import FirebaseFirestore

struct U5_Congrats: View {
    //var transactionId: String
    @Binding var showCongrats: Bool
    var body: some View{
        ZStack {
            VStack{
                Color(red: 9/255, green: 91/255, blue: 148/255)
                .frame(width: 1000, height: 450)
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0,maxHeight: .infinity,alignment: .bottom)
            .edgesIgnoringSafeArea(.bottom)
    
            VStack(spacing: 300){
                VStack(spacing: 10){
                    Text("CONGRATULATIONS!")
                        .foregroundColor(Color(red: 111/255, green: 111/255, blue: 111/255))
                        .font(.system(size: 20))
                        .fontWeight(.heavy)
                    Text("You have a Match.")
                        .font(.system(size: 16))
                        .foregroundColor(Color(red: 111/255, green: 111/255, blue: 111/255))
                    
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(Color(red: 254/255, green:139/255, blue: 93/255))
                        .font(.system(size: 60))
                }
                
                
            
                Button(action: {
                   
                    self.showCongrats.toggle()
                    
                }) {
                    
                    Text("See details")
                        .foregroundColor(Color(red: 111/255, green: 111/255, blue: 111/255))
                        .font(.system(size: 16))
                        .fontWeight(.bold)
                        .frame(width: 275, height: 50)
                        .background(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 20, style:.continuous))
                        .shadow(color:Color(#colorLiteral(red: 0.1899434371, green: 0.2814861356, blue: 0.5359386339, alpha: 1)) , radius: 5, x: 5, y: 5)
                        .shadow(color:Color(#colorLiteral(red: 0.1899434371, green: 0.2814861356, blue: 0.5359386339, alpha: 1)), radius: 5, x: -5, y: -5)
                }
            
            }
           
        }
//        .navigationBarBackButtonHidden(true)
        .onAppear {
            print("this is U5_Congrats at line 60")
        }
    }
}

