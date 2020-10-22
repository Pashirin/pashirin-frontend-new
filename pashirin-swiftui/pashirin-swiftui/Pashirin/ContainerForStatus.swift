//
//  ContainerForStatus.swift
//  pashirin-swiftui
//
//  Created by HONGHYONGGUK on 2020/10/19.
//  Copyright © 2020 HONGHYONGGUK. All rights reserved.
//

import SwiftUI

struct ContainerForStatus: View {
    @ObservedObject var waitingViewModel = WaitingViewModel()
    var body: some View {
        if waitingViewModel.status == 2 {
            P3_Congrats()
        } else if waitingViewModel.status == 3 {
            Deliver()
        } else if waitingViewModel.status == 4 {
            TaskComplete()
        }
    }
}

struct ContainerForStatus_Previews: PreviewProvider {
    static var previews: some View {
        ContainerForStatus()
    }
}
