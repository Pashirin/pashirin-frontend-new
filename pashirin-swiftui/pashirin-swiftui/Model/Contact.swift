//
//  BookListView.swift
//  dataFetch
//
//  Created by Eri Koyano on 2020/10/12.
//

import Foundation

struct Contact: Identifiable {
    var id: String =  UUID().uuidString
    var transactionId: String
    var delivery: Int
    var startlocation: String
    var destination: String
    var detail: String
    var name: String
    var price: Int
    var rating: String
    var item :String
    
    
}
