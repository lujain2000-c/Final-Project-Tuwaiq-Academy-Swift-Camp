//
//  ProfileStudent.swift
//  GP-OnboardingSign
//
//  Created by Razan Mohammed Alzannan on 29/11/1444 AH.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
import UIKit
struct ProfileStudent: View {
    
    var currentCard: Card
    
     @StateObject var vm = DataManager()
     @State private var showingSheetEdit = false
     @State var isPresented = false
     @State private var isEditMode = false
     @State private var selectedPhoto: UIImage?
     @State var name : String = ""
     @State var phone : String = ""
    @State var balanse : String = "0.0"
    var Schools = ["Start Smart School","Passion Education School","Little Feats School","First Elemrntry School","Learning Tree School","A Step Ahead School", "Little Green Tree House School"]
    @State private var School = "Start Smart School"
    var gender = ["M", "F"]
    @State private var genderTayp = "F"
    
     var body: some View {
        // NavigationStack {
         VStack{
             
             ZStack {
                 Rectangle()
                     .foregroundColor(Color("purplei"))
                     .edgesIgnoringSafeArea(.top)
                     .frame(height: 150)
                 //                         .toolbar{
                 //                             HStack{
                 //                                 Image(systemName: "chevron.backward")
                 //                                 Button("Back"){}.foregroundColor(.black)
                 //
                 //
                 ////                                 Button("Sign Out"){
                 ////                                     let firebaseAuth = Auth.auth()
                 ////                                     do {
                 ////                                         try firebaseAuth.signOut()
                 ////                                         let user = Auth.auth().currentUser;
                 ////                                         if (user == nil) {
                 ////                                             print("signed out succesfully")
                 ////                                         }
                 ////                                     } catch let signOutError as NSError {
                 ////                                         print("Error signing out: %@", signOutError)
                 ////                                     }
                 ////
                 ////                                 }.foregroundColor(.black)
                 //                             }
                 //
                 //
                 //                         }
                 Image(uiImage: selectedPhoto ?? UIImage(named: "Image 2")!)
                     .resizable()
                     .frame(width: 120, height: 120)
                     .clipShape(Circle())
                     .shadow(radius: 10)
                 
//                 if isEditMode {
//                     Button("Change Photo") {
//                         self.showImagePicker()
//                     }.padding()
//                 }
             }
             //
             VStack(alignment: .leading,spacing: 32){
                 if isEditMode {
                     Button("Save"){ self.isEditMode.toggle()
                         let balanse1 = Double(balanse)
                         vm.updateChild(ChildID: vm.child.studentNationalId, newChildName: name, newChildSchool: School, newChildBalanse: balanse1 ?? 0.0, gender: genderTayp )
                     }
                     
                 }else{
                     Button("Edit"){ self.isEditMode.toggle()}
                 }
                 
                 HStack(spacing: 16){
                     Image(systemName: "person")
                         .resizable()
                         .frame(width:24,height: 24)
                         .foregroundColor(Color("purplei"))
                     
                     if isEditMode {
                         TextField("Name", text: $name)
                             .textFieldStyle(RoundedBorderTextFieldStyle())
                     }else{
                         Text(vm.child.studentName)
                     }
                 }
                 Divider()
                 HStack(spacing: 16){
                     Image(systemName: "book")
                         .resizable()
                         .frame(width:24,height: 24)
                         .foregroundColor(Color("purplei"))
                     
                     if isEditMode {
                         Text("Select school")
                         Picker("Select school", selection: $School) {
                             ForEach(Schools, id: \.self) {
                                 
                                 Text($0)
                                     .foregroundColor(.primary)
                                 
                             }
                         }
                     } else {
                         Text(vm.child.studentSchoolName)
                     }
                     
                 }
                 Divider()
                 HStack(spacing: 20){
                     Image(systemName: "key.radiowaves.forward")
                         .resizable()
                         .frame(width:24,height: 24)
                         .foregroundColor(Color("purplei"))
                     Text(vm.child.studentNationalId)
                         .font(.custom( "Play-Regular", size: 16))
                     
                 }
                 Divider()
                 HStack(spacing: 16){
                     Image(systemName: "creditcard")
                         .resizable()
                         .frame(width:24,height: 24)
                         .foregroundColor(Color("purplei"))
                     
                     if isEditMode {
                         TextField("Curent balanse", text: $balanse)
                             .textFieldStyle(RoundedBorderTextFieldStyle())
                             .keyboardType(.numberPad)
                     }else{
                         Text("\(vm.child.studentBalance, specifier: "%.1f")")
                     }
                 }
                 Divider()
                 
                 
                 
                 if isEditMode {
                     HStack(spacing: 16){
                         Image(systemName: "figure.dress.line.vertical.figure")
                             .resizable()
                             .frame(width:24,height: 24)
                             .foregroundColor(Color("purplei"))
                         Text("Select gender")
                         Picker("Select gender", selection: $genderTayp) {
                             ForEach(gender, id: \.self) {
                                 
                                 Text($0)
                                     .foregroundColor(.primary)
                                 
                             }
                         }
                     }
                     //                             else {
                     //                                 Text(vm.child.studentGender)
                     //                             }
                     
                 }
                 //  Divider()
                 
                 
                 //                         Divider()
                 //                         HStack(spacing: 20){
                 //                             Image(systemName: "creditcard")
                 //                                 .resizable()
                 //                                 .frame(width:25,height: 25)
                 //                                 .foregroundColor(Color("purplei"))
                 //                             // payment
                 //                             Text("current balance").font(.custom( "Play-Regular", size: 20))
                 //
                 //                         }
                 
                 
                 
                 
             }.padding(.all,24)
             Spacer()
             if !isEditMode {
                 VStack{
                     ZStack{
                         Button("Add credit"){
                             
                         }
                         .foregroundColor(Color.white)
                         .font(.custom( "Play-Regular", size: 24))
                         .fontWeight(.semibold)
                         .frame(maxWidth: .infinity, maxHeight: 50)
                         .background(Color("purplei"))
                         .cornerRadius(10)
                         .padding(.horizontal)
                         .padding(.bottom)
                         .shadow(radius: 4)
                         .foregroundColor(Color("orangi"))
                         Link("Pay", destination: URL(string: "https://buy.stripe.com/test_9AQ6qqdbYd6MeNq9AA")!)
                             .foregroundColor(Color("purplei"))
                         //.foregroundColor(Color("purplei"))//.opacity(0.1)
                         //"https://buy.stripe.com/test_9AQ6qqdbYd6MeNq9AA"
                     }
                     NavigationLink(destination: HomeView()){
                         Button("Delete card"){
                             vm.deleteChild(childID: currentCard.cardNumber)
                         }
                         .foregroundColor(Color.white)
                         .font(.custom( "Play-Regular", size: 24))
                         .fontWeight(.semibold)
                         .frame(maxWidth: .infinity,maxHeight: 50)
                         .background(Color("pinki"))
                         .cornerRadius(10)
                         .padding(.horizontal)
                         .padding(.bottom)
                         .shadow(radius: 4)
                     }
                 }
             }
             }
                 .onAppear{
                     vm.fetchChild(childName: currentCard.name)
                 }

             //}
             }
         
         
     // Image Picker Code

     @State private var isShowingImagePicker = false

     func showImagePicker() {
         self.isShowingImagePicker = true
     }

     func loadImage() {
         guard let selectedPhoto = selectedPhoto else { return }
         // some code for saving the image to server or local storage
     }
}

//struct ProfileStudent_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileStudent()
//    }
//}
