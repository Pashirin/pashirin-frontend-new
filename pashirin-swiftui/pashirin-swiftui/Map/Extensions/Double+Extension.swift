//
//  Double+Extension.swift
//  pashirin-swiftui
//
//  Created by HONGHYONGGUK on 2020/10/27.
//  Copyright © 2020 HONGHYONGGUK. All rights reserved.
//


import UIKit

extension Double {
    
    func truncate(places : Int)-> Double {
        return Double(floor(pow(10.0, Double(places)) * self)/pow(10.0, Double(places)))
    }
}

