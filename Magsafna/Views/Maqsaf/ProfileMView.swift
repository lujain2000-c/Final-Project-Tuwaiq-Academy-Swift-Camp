//
//  ProfileMView.swift
//  GP-OnboardingSign
//
//  Created by Razan Mohammed Alzannan on 29/11/1444 AH.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
import UIKit

struct ProfileMView: View {
    
     @StateObject var vm = DataManager()
     @State private var showingSheetEdit = false
     @State var isPresented = false
     @State private var isEditMode = false
     @State private var selectedPhoto: UIImage?
   
     @State var name : String = ""
     @State var phone : String = ""
     @State var paymentLink : String = "https://buy.stripe.com/test_9AQ6qqdbYd6MeNq9AA"
    var Schools = ["Start Smart School","Passion Education School","Little Feats School","First Elemrntry School","Learning Tree School","A Step Ahead School", "Little Green Tree House School"]
    @State private var School = "Start Smart School"
    
     var body: some View {
         NavigationStack {
             VStack{
                 
                 ZStack {
                     Rectangle()
                         .foregroundColor(Color("purplei"))
                         .edgesIgnoringSafeArea(.top)
                         .frame(height: 150)
                        .toolbar{
                     NavigationLink(destination: StartingView()){
                     Button("Sign Out"){
                         let firebaseAuth = Auth.auth()
                         do {
                             try firebaseAuth.signOut()
                             let user = Auth.auth().currentUser;
                             if (user == nil) {
                                 print("signed out succesfully")
                             }
                         } catch let signOutError as NSError {
                             print("Error signing out: %@", signOutError)
                         }
                         
                     }.foregroundColor(.black)
                     
                 }
                        }
                     Image(uiImage: selectedPhoto ?? UIImage(named: "Image 1")!)
                         .resizable()
                         .frame(width: 120, height: 120)
                         .clipShape(Circle())
                         .shadow(radius: 10)
                         
//                     if isEditMode {
//                         Button("Change Photo") {
//                             self.showImagePicker()
//                         }.padding()
//                     }
                         }
                     //
                     VStack(alignment: .leading,spacing: 32){
                         if isEditMode {
                             Button("Save"){
                                 
                                 self.isEditMode.toggle()
                                 
                                 vm.updateMaqsaf(schoolName: name , phoneNumber: phone , paymentLink: vm.school.schoolPayment )
                             }
                            
                         }else{
                             Button("Edit"){ self.isEditMode.toggle()}
                         }
                     
//                         HStack(spacing: 20){
//                             Image(systemName: "person")
//                                 .resizable()
//                                 .frame(width:25,height: 25)
//                                 .foregroundColor(Color("purplei"))
//
//                             if isEditMode {
//                                 TextField("Name", text: $name)
//                                     .textFieldStyle(RoundedBorderTextFieldStyle())
//                             }else{
//                                 Text(vm.school.schoolName)
//                             }
//                         }
//                         Divider()
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
                                             .foregroundColor(.white)
                                         
                                     }
                                 }
                             }
                             else{
                                 Text(vm.school.schoolName)
                                     .font(.custom( "Play-Regular", size: 19))
                                 
                             }}
                         Divider()
                         HStack(spacing: 16){
                             Image(systemName: "envelope")
                                 .resizable()
                                 .frame(width:24,height: 24)
                                 .foregroundColor(Color("purplei"))
                             Text(vm.school.schoolId)
                                 .font(.custom( "Play-Regular", size: 16))
                             
                         }
                         
                         Divider()
                             HStack(spacing: 16){
                                 Image(systemName: "phone")
                                     .resizable()
                                     .frame(width:24,height: 24)
                                     .foregroundColor(Color("purplei"))
                                 if isEditMode {
                                     TextField("Phone number", text: $phone)
                                         .textFieldStyle(RoundedBorderTextFieldStyle())
                                  }else{
                                 Text(vm.school.schoolPhone)
                                     .font(.custom( "Play-Regular", size: 16))
                             }
                         
                             
                             
                         }
                         Divider()
                         
                         HStack(spacing: 16){
                             Image(systemName: "link")
                                 .resizable()
                                 .frame(width:24,height: 24)
                                 .foregroundColor(Color("purplei"))
                            // Text(vm.school.schoolPayment)
                                 //   .font(.custom( "Play-Regular", size: 19))
                             if isEditMode {
                                 TextField("Payment link", text: $paymentLink)
                                     .textFieldStyle(RoundedBorderTextFieldStyle())
                              }else{
                             Text(vm.school.schoolPayment)
                                 .font(.custom( "Play-Regular", size: 16))
                         }
                         }
                         
                     }.padding(.all,24)
                     .padding(.bottom,24)
                     Spacer()
                 if !isEditMode {
                     NavigationLink("Password Reset"){
                         ResetPasswordView()
                     }
                     .foregroundColor(Color.white)
                     .font(.custom( "Play-Regular", size: 24))
                     .fontWeight(.semibold)
                     .frame(maxWidth: .infinity,maxHeight: 50)
                     .background(Color("purplei"))
                     .cornerRadius(10)
                     .padding(.bottom,80)
                     .shadow(radius: 4)
                     .padding(.horizontal)
                 }
             }.onAppear{
                 vm.fetchMaqsaf()
             }
             } .sheet(isPresented: $isShowingImagePicker, onDismiss: loadImage) {
                 ImagePicker(image: self.$selectedPhoto)
             }
         
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


struct ProfileMView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileMView()
    }
}
