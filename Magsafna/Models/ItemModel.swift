//
//  ItemModel.swift
//  Magsafna
//
//  Created by لجين إبراهيم الكنهل on 03/12/1444 AH.
//

import Foundation

struct Item: Identifiable{
   var id = UUID()
    var name: String
    var price: String
    
}

class ItemViewModel: ObservableObject{
   @Published var items = [
        Item(name: "Cheese sandwich", price: "2"),
        Item(name: "Chocolata sandwich", price: "2"),
        Item(name: "Apple juice", price: "1"),
        Item(name: "Water", price: "1"),
        Item(name: "Popcorn", price: "1"),
        
    ]
}
