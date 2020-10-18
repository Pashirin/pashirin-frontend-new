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
    @State var isDeliverd = false
    var body: some View{
        if !self.isDeliverd {
            
            ZStack {
                Color.gray.edgesIgnoringSafeArea(.all)
                    .opacity(0.4)
                VStack{
                    Text("Currently Delivering...")
                        .padding(.top, 50)
                        .font(.title)
                    Image("running")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 60, height: 60)
                    Text("Tap Here Once You Have Completed Your Task")
                        .padding(13.0)
                    
                    Button(action: {
                        print("Button Clicked")
                        self.isDeliverd.toggle()
                    }) {
                        
                        Text("Completed")
                            .foregroundColor(.white)
                            .font(.title)
                            .padding()
                            .border(Color.white, width: 5)
                    }
                }
            }
        } else {
            TaskComplete()
        }
        
    }
}


struct Deliver_Previews: PreviewProvider {
    static var previews: some View {
        Deliver()
    }
}

