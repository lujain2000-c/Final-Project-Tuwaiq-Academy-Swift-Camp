//
//  ListenerView.swift
//  Magsafna
//
//  Created by لجين إبراهيم الكنهل on 03/12/1444 AH.
//

import SwiftUI

struct ListenerView: View {
    @EnvironmentObject var vm: DataManager
   // @StateObject var vm = DataManager()
    //@Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack{
            //Color("purplei")
           
            if vm.userType == "parent"{
             
               TabBarView()
            }else{
           
             TabBarMView()
            }
        }
    }
}

//struct ListenerView_Previews: PreviewProvider {
//    static var previews: some View {
//        ListenerView()
//    }
//}
