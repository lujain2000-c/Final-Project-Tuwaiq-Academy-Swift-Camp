//
//  ExpenseModel.swift
//  GPProject
//
//  Created by لجين إبراهيم الكنهل on 25/11/1444 AH.
//

import Foundation
import SwiftUI
// MARK: Expense Model and Sample Data
struct Expense: Identifiable{
    var id = UUID().uuidString
    var amountSpent: String
    var product: String
//var producticon: String
    var spendType: String
}
var expenses: [Expense] = [
Expense(amountSpent: "$3", product: "Water", spendType:
"Groceries"),
Expense(amountSpent: "$2", product: "Chocolate", spendType:
"Streaming"),
Expense(amountSpent: "$1", product: "Dribbble", spendType:
            "Membership")
]
