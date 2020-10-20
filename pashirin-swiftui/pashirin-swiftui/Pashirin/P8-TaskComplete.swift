//
//  TaskComplete.swift
//  StaticPages
//
//  Created by Eri Koyano on 2020/10/12.
//

import Foundation
import SwiftUI

struct TaskComplete: View {
    var body: some View{
        ZStack {
            Color.green.edgesIgnoringSafeArea(.all)
                .opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)
            VStack{
            Text("Well Done!")
                .padding(.top, 50)
                .font(.title)
            Image("running")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 60, height: 60)
                Text("You Have Completed your Task!")
                    .padding(13.0)
            
                
                NavigationLink(destination: P1_ListView()){
//                    Button(action: {
//                        print("Button Clicked")
//                    }) {
                        
                        Text("Back to Menu")
                            .foregroundColor(.white)
                            .font(.title)
                            .padding()
                            .border(Color.white, width: 5)
//                    }
                
                    
                }
            }
                
        }
    }
}


struct TaskComplete_Previews: PreviewProvider {
    static var previews: some View {
        TaskComplete()
    }
}
