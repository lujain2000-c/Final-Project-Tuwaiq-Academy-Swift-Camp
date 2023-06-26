//
//  SwiftUIView.swift
//  Magsafna
//
//  Created by لجين إبراهيم الكنهل on 02/12/1444 AH.
//

import SwiftUI

struct SwiftUIView: View {
    @StateObject var vm = ItemViewModel()
       var body: some View {
           VStack{
               List(vm.items){item in
                   
                   HStack{
                       Text(item.name)
                       Spacer()
                       Text(item.price)
                   }
                   
               }
               
                         

           }
       }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}
