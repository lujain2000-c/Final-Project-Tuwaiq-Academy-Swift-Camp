//
//  TabBarModel.swift
//  GPProject
//
//  Created by لجين إبراهيم الكنهل on 26/11/1444 AH.
//

import SwiftUI
struct TabItem: Identifiable {
    var id = UUID()
    var text: String
    var icon: String
    var tab: Tab
    var color: Color
}
var tabItems = [
    TabItem(text: "Home", icon: "house", tab: .home, color: .teal),
    TabItem(text: "Profile", icon: "person", tab: .profile, color: .purple),
    TabItem(text: "Write ", icon: "creditcard", tab: .writeInfo, color: .mint),
    TabItem(text: "Library", icon: "rectangle.stack", tab: .library, color: .pink)
    ]

var tabItemsM = [
    TabItem(text: "Home", icon: "house", tab: .home, color: .teal),
    TabItem(text: "Profile", icon: "person", tab: .profile, color: .purple),
    TabItem(text: "Scan ", icon: "barcode.viewfinder", tab: .writeInfo, color: .mint),
   TabItem(text: "Library", icon: "rectangle.stack", tab: .library, color: .pink)
    ]

enum Tab: String {
    case home
    case profile
    case writeInfo
    case library
}
