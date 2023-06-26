//
//  CartModel.swift
//  GPProject
//
//  Created by لجين إبراهيم الكنهل on 25/11/1444 AH.
//

import SwiftUI



struct Card: Identifiable{
    var id = UUID().uuidString
    var name: String
    var cardNumber: String
    var cardColor: [Color]

}
var number = ["4345 5687 7867 0978","5687 4345 7867 5687", "7867 4345 5687 7867"]
var colors = [
    [Color(#colorLiteral(red: 0.9843137255, green: 0.9176470588, blue: 0.6470588235, alpha: 1)), Color(#colorLiteral(red: 1, green: 0.3333333333, blue: 0.6117647059, alpha: 1)), Color(#colorLiteral(red: 0.4156862745, green: 0.7098039216, blue: 0.9294117647, alpha: 1)), Color(#colorLiteral(red: 0.337254902, green: 0.1137254902, blue: 0.7490196078, alpha: 1)), Color(#colorLiteral(red: 0.337254902, green: 0.9215686275, blue: 0.8509803922, alpha: 1))],
    [Color(#colorLiteral(red: 0.9843137255, green: 0.9176470588, blue: 0.6470588235, alpha: 1)), Color(#colorLiteral(red: 0.4156862745, green: 0.7098039216, blue: 0.9294117647, alpha: 1)), Color(#colorLiteral(red: 0.337254902, green: 0.9215686275, blue: 0.8509803922, alpha: 1))],
    [Color(#colorLiteral(red: 0.4156862745, green: 0.7098039216, blue: 0.9294117647, alpha: 1)), Color(#colorLiteral(red: 0.337254902, green: 0.1137254902, blue: 0.7490196078, alpha: 1)), Color(#colorLiteral(red: 0.337254902, green: 0.9215686275, blue: 0.8509803922, alpha: 1))] ,
    [Color(#colorLiteral(red: 1, green: 0.3333333333, blue: 0.6117647059, alpha: 1)), Color(#colorLiteral(red: 0.4156862745, green: 0.7098039216, blue: 0.9294117647, alpha: 1)), Color(#colorLiteral(red: 0.337254902, green: 0.9215686275, blue: 0.8509803922, alpha: 1))]
]

//var cards: [Card] = [Card (name: "¡Justine", cardNumber: number.randomElement()! , cardColor: colors.randomElement()!)]
