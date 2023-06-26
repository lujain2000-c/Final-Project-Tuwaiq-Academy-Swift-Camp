//
//  ProfileParentView.swift
//  GPProject
//
//  Created by لجين إبراهيم الكنهل on 26/11/1444 AH.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
import UIKit

struct ProfileParentView: View {
   
    @StateObject var vm = DataManager()
    @State private var showingSheetEdit = false
    @State var isPresented = false
    @State private var isEditMode = false
    @State private var selectedPhoto: UIImage?
    @State var name : String = ""
    @State var phone : String = ""
   // @State var isSignOut = false
    
//    @ViewBuilder
//    var body: some View {
//        if isSignOut {
//            StartingView()
//     } else {
//         ProfileParentView()
//     }
//    }
    
    var body: some View {
//        VStack{
//            Group {
//                if vm.signOut {
//                    StartingView()
//                }else{
//                    TabBarView()
//                }
//            }
//        }
    
        NavigationStack {
            VStack{
                
                ZStack {
                    Rectangle()
                        .foregroundColor(Color("purplei"))
                        .edgesIgnoringSafeArea(.top)
                        .frame(height: 150)
                    
                    
                        .toolbar {
                            
//                            NavigationLink(destination: isSignOut ? StartingView() : ProfileParentView()){
                            
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
                                    vm.signOutUser()
                                  //  isSignOut = true
                                    
                                }.foregroundColor(.primary)
                          //  }
                            
                        }
                    Image(uiImage: selectedPhoto ?? UIImage(named: "parent")!)
                        .resizable()
                        .frame(width: 120, height: 120)
                        .clipShape(Circle())
                        .shadow(radius: 10)
                    
                    //                    if isEditMode {
                    //                        Button("Change Photo") {
                    //                            self.showImagePicker()
                    //                        }.padding()
                    //                    }
                }
                //
                VStack(alignment: .leading,spacing: 32){
                    if isEditMode {
                        Button("Save"){ 
                            self.isEditMode.toggle()
                            
                            vm.updateParent(newFullName: name, newPhoneNumber: phone)
                            
                            
                            
                            
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
                            Text(vm.parent.parentName)
                        }
                    }
                    Divider()
                    
                    HStack(spacing: 16){
                        Image(systemName: "envelope")
                            .resizable()
                            .frame(width:24,height: 24)
                            .foregroundColor(Color("purplei"))
                        Text(vm.parent.parentId)
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
                            Text(vm.parent.parentPhone)
                                .font(.custom( "Play-Regular", size: 16))
                        }
                        
                        
                        
                    }
                    Divider()
                    
                    //                        HStack(spacing: 20){
                    //                            Image(systemName: "link")
                    //                                .resizable()
                    //                                .frame(width:25,height: 25)
                    //                                .foregroundColor(Color("purplei"))
                    //                            Text("Pay link")
                    //                                .font(.custom( "Play-Regular", size: 19))
                    //                        }
                    
                }.padding(.all,24)
                Spacer()
                if !isEditMode {
                NavigationLink("Password Reset"){
                    ResetPasswordView()
                }
                .foregroundColor(Color.white)
                .font(.custom( "Play-Regular", size: 20))
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity,maxHeight: 50)
                .background(Color("purplei"))
                .cornerRadius(10)
                .padding(.bottom,110)
                .shadow(radius: 4)
                .padding(.horizontal)
            }

            }.onAppear{
                vm.fetchParent()
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

struct ImagePicker: UIViewControllerRepresentable {

    @Environment(\.presentationMode) var presentationMode

    @Binding var image: UIImage?

    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = context.coordinator
        return imagePicker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {}

    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }

    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

        let parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.image = image
            }

            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}


struct ProfileParentView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileParentView()
    }
}
