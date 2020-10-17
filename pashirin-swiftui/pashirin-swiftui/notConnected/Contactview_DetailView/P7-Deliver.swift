
//
//  P5-Deliver.swift
//  StaticPages
//
//  Created by Eri Koyano on 2020/10/12.
//
import Foundation
import SwiftUI
// to be overlayed on top of
struct Deliver: View {
    var body: some View{
        ZStack {
            Spacer()
           Image("P5Delivering")
               .resizable()
            .scaledToFill()
            .edgesIgnoringSafeArea(.all)
            VStack{
                Text(LocalizedStringKey("Currently Delivering"))
                    .padding(.top, 50)
                    .font(Font.custom("LEMONMILK-Light",size: 28))
                    
                LottieView(filename: "Delivery")
                    .frame(width: 200, height: 200)
                    Text(LocalizedStringKey("Tap Here Once You Have Completed Your Task"))
                        .padding(13.0)
                        .font(Font.custom("Barlow-Medium",size: 18))
                
            Button(action: {
                    print("Button Clicked")
                }) {
                
                Text(LocalizedStringKey("Completed"))
                    .foregroundColor(Color(.lightGray))
                    .padding()
                    .font(Font.custom("LEMONMILK-Light",size: 21))
                    .overlay(
                    RoundedRectangle(cornerRadius: 26)
                        .stroke(Color(.lightGray),lineWidth: 5))
                    
                }
            }
        }
    }
}


struct Deliver_Previews: PreviewProvider {
    static var previews: some View {
        Deliver()
    }
}
