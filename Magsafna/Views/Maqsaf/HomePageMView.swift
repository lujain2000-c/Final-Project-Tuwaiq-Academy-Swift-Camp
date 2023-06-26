//
//  HomePageMView.swift
//  Magsafna
//
//  Created by لجين إبراهيم الكنهل on 02/12/1444 AH.
//

import SwiftUI


struct HomePageMView: View {
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

struct HomePageMView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageMView()
    }
}

