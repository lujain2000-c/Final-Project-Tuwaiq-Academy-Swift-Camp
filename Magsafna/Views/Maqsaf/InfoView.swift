//
//  InfoView.swift
//  Magsafna
//
//  Created by لجين إبراهيم الكنهل on 01/12/1444 AH.
//

import SwiftUI

struct InfoView: View {
    @EnvironmentObject var vm: DataManager
   
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
//        VStack {
//            
//          
//                
//                Button("Cancel") {
//                    dismiss()
//                    
//                }
//            Text(vm.childM.studentNationalId)
//            Text(vm.childM.studentName)
//            Text("\(vm.childM.studentBalance)")
//            
//            
//        }
        ZStack {
                    Color("purplei")
                        .ignoresSafeArea()
                    VStack {
                        Button("Cancel") {
                                           dismiss()
                       
                                       }
                    Image("AbdullahFahad")
                            .resizable()
                            .frame(width: 190,height: 190)
                            .clipShape(Circle())
                            .padding(.top,0)
                            .shadow(radius: 10)
                    Text(vm.childM.studentName)
                            .font(.custom( "Play-Regular", size: 30))
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                            .padding()
                    
                    Text("\(vm.childM.studentBalance)")
                            .font(.custom( "Play-Regular", size: 22))
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                            .padding()
                        
                        VStack{
                            HStack(spacing: 8){
                                Image(systemName: "wrongwaysign")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(.red)
                                    
                                Text("Alergies:")
                                    .font(.custom( "Play-Regular", size: 26))
                                    .fontWeight(.bold)
                                    .foregroundColor(.black)
                                    .multilineTextAlignment(.leading)
                                   
                                    
                            }
                            Text("- Peanut Petter Alergey\n\n- Pistio Alergey")                    .font(.custom( "Play-Regular", size: 19))
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                                .padding()
                            
                            Divider()
                                .padding(.all)
                                .foregroundColor(.black)
                                .bold()
                           
                            
                                
                        
                            
                        }
                    }
                }.navigationTitle("Student Information")
    }
}

//struct InfoView_Previews: PreviewProvider {
//    static var previews: some View {
//        InfoView( )
//    }
//}
