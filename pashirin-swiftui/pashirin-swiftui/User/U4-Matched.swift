//
//  ContentView.swift
//  StaticPages
//
//  Created by Eri Koyano on 2020/10/12.
//

import SwiftUI

struct U4_Matched: View {
    var body: some View{
        ZStack {
            Color.blue.edgesIgnoringSafeArea(.all)
            VStack{
            Text("Congratulations!")
                .padding(.top, 50)
                .font(.title)
            Image("running")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 60, height: 60)
                Text("You have a Match!")
                    .padding(13.0)
                
            Button(action: {
                    print("Button Clicked")
                }) {
                
                    Text("Chat Now")
                        .foregroundColor(.white)
                        .font(.title)
                        .padding()
                        .border(Color.white, width: 5)
                }
            }
    }

    }



}
    
