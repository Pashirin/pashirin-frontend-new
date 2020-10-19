//
//  AfterRequest.swift
//  pashirin-swiftui
//
//  Created by HONGHYONGGUK on 2020/10/15.
//  Copyright © 2020 HONGHYONGGUK. All rights reserved.
//

import SwiftUI

struct AfterRequest: View {
    @ObservedObject var waitingViewModel = WaitingViewModel()
    var body: some View {
        if waitingViewModel.status == 1 {
            PWait()
        } else if waitingViewModel.status == 4  {
            Thankyou()
        } else {
            U5_DetailView()
            
        }
    }
}

struct AfterRequest_Previews: PreviewProvider {
    static var previews: some View {
        AfterRequest()
    }
}
