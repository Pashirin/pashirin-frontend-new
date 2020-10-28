//
//  LoadingView.swift
//  Animation
//
//  Created by Eri Koyano on 2020/10/13.
// 

import SwiftUI



struct RunningView: View {
    @State private var isActive = false
    @State private var isVisible = false
    
    
    var body: some View {
        VStack {
            if self.isActive {
                ContentView()
            } else {
                VStack{
                    LottieView(filename: "Run")
                        .frame(width:200, height:200)
                        .padding(.bottom, -20)
                        .padding(.top, -40)
                    Text("PASHIRIN")
                }
                .font(Font.custom("LEMONMILK-Medium",size: 33))
                .opacity(isVisible ? 1 : 0)
                .scaleEffect(isVisible ? 1.5 : 1)
                .onAppear{
                    withAnimation(.easeOut(duration: 0.8)){
                        self.isVisible.toggle()
                    }
                    
                }
            }
            
            
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
                withAnimation {
                    self.isActive = true
                }
            }
        }
        
    }
}


struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        RunningView()
    }
}
