//
//  ContentView.swift
//  pashirin-swiftui
//
//  Created by HONGHYONGGUK on 2020/10/07.
//  Copyright © 2020 HONGHYONGGUK. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    //デフォルトではfalse
    @State var isSignedUp = true
    @State var loginStatus = false
    var body: some View {
  
        if !isSignedUp {
            RegFormView(isSignedUp: $isSignedUp)
        } else {
      UserPashirin()
           
           
        }
   }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
