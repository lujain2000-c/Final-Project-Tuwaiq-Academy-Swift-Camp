//
//  AddChildView.swift
//  GPProject
//
//  Created by لجين إبراهيم الكنهل on 27/11/1444 AH.
//

import SwiftUI

struct AddChildView: View {
    
    @StateObject var vm = DataManager()
    @Environment(\.dismiss) var dismiss

    @State var textFieldName: String = ""
    @State var textFieldID: String = ""
    var Schools = ["Start Smart School","Passion Education School","Little Feats School","First Elemrntry School","Learning Tree School","A Step Ahead School", "Little Green Tree House School"]
    @State private var School = "Start Smart School"
    var gender = ["M", "F"]
    @State private var genderTayp = "F"
    var body: some View {
        
        VStack{
            ScrollView{
            
            HStack{
                Spacer()
                    .toolbar {
                        Button("Add"){
    
                            vm.addChild(childID: textFieldID, childName: textFieldName, childSchool: School, childGender: genderTayp)
                            
                            dismiss()
                        }
                    }
                    .font(.headline)
                    .foregroundColor(Color("purplei"))
                
            }
//            Circle()
//                .stroke()
//                .frame(width: 120, height: 120)
           // Spacer()
            
            VStack(alignment: .leading,spacing: 30){
                HStack(spacing: 20){
                    Image(systemName: "person")
                        .resizable()
                        .frame(width:25,height: 25).foregroundColor(Color("purplei"))
                    
                    TextField("Name",text: $textFieldName)
                    
                }
                Divider()
                HStack(spacing: 20){
                    Image(systemName: "key.radiowaves.forward")
                        .resizable()
                        .frame(width:25,height: 25).foregroundColor(Color("purplei"))
                    TextField("ID number",text: $textFieldID)
                    
                }
                Divider()
                HStack(spacing: 20){
                    Image(systemName: "book")
                        .resizable()
                        .frame(width:25,height: 25)
                        .foregroundColor(Color("purplei"))
                    Text("Select school")
                    Picker("Select school", selection: $School) {
                        ForEach(Schools, id: \.self) {
                            
                            Text($0)
                                .foregroundColor(.primary)
                            
                        }
                    }
                    
                    
                }
                Divider()
                
                HStack(spacing: 20){
                    Image(systemName: "figure.dress.line.vertical.figure")
                        .resizable()
                        .frame(width:25,height: 25)
                        .foregroundColor(Color("purplei"))
                    Text("Gender")
                    Picker("gender", selection: $genderTayp) {
                        ForEach(gender, id: \.self) {
                            
                            Text($0)
                                .foregroundColor(.primary)
                            
                        }
                    }
                    
                    
                }
                Divider()
                
            }.padding()
                    .padding(.top,40)
            Spacer()
            
            
        }
        }.padding()
    }
}


struct AddChildView_Previews: PreviewProvider {
    static var previews: some View {
        AddChildView()
    }
}
