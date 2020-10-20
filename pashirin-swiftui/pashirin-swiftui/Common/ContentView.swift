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
    @State var isSignedUp = false
    @State var hasAccount = false
    @State var loginStatus = false
    @State var signedIn = false
    var body: some View {
        if signedIn {
            UserPashirin()
        } else if !isSignedUp {
            RegFormView(isSignedUp: $isSignedUp, hasAccount: $hasAccount, signedIn: $signedIn)
                .transition(.scale)
        } else if hasAccount {
            LoginView(isSignedUp: $isSignedUp, hasAccount: $hasAccount, signedIn: $signedIn)
                .transition(.scale)
        }
        
//
//
//
//        if !isSignedUp {
//            RegFormView(isSignedUp: $isSignedUp, hasAccount: $hasAccount, signedIn: $signedIn)
//                .transition(.scale)
//        } else if hasAccount {
//            LoginView(isSignedUp: $isSignedUp, hasAccount: $hasAccount, signedIn: $signedIn)
//                .transition(.scale)
//        } else if signedIn {
//            UserPashirin()
//        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
