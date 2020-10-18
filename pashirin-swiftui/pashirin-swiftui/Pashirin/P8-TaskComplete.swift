//
//  TaskComplete.swift
//  StaticPages
//
//  Created by Eri Koyano on 2020/10/12.
//

import Foundation
import SwiftUI

struct TaskComplete: View {
    @State var isButtonPushed = false
    
    var body: some View{
        if !isButtonPushed {
            
            ZStack {
                        Spacer()
                       Image("P6")
                           .resizable()
                        .scaledToFill()
                        .edgesIgnoringSafeArea(.all)
                VStack{
                    Text(LocalizedStringKey("Well Done"))
                        .padding(.top, 50)
                        .font(Font.custom("LEMONMILK-Light",size: 28))
                        
                    LottieView(filename: "thumbsup")
                        .frame(width: 200, height: 200)
                        Text(LocalizedStringKey("You Have Completed Your Task!"))
                            .padding(13.0)
                            .font(Font.custom("Barlow-Medium",size: 18))
                    
                    Button(action: {
                        print("Button Clicked")
                        self.isButtonPushed.toggle()
                    }) {
                        
                        Text("Back to Menu")
                            .foregroundColor(Color(.lightGray))
                            .padding()
                            .font(Font.custom("LEMONMILK-Light",size: 21))
                            .overlay(
                            RoundedRectangle(cornerRadius: 26)
                                .stroke(Color(.lightGray),lineWidth: 5))
                    }
                }
            }
        } else {
            P1_ListView()
        }
    }
}


struct TaskComplete_Previews: PreviewProvider {
    static var previews: some View {
        TaskComplete()
    }
}
