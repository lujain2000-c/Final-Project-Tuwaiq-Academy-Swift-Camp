//
//  ProfileHeader.swift
//  GP-OnboardingSign
//
//  Created by Razan Mohammed Alzannan on 27/11/1444 AH.
//

import SwiftUI
import PhotosUI

struct ProfileHeader: View {
    //    @State private var selectedItem: PhotosPickerItem? = nil
    //        @State private var selectedImageData: Data? = nil
    //    @State private var image = UIImage()
    @State var shouldShowImagePicker = false
    @State var image: UIImage?
    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                
                Rectangle()
                    .foregroundColor(Color("greeni"))
                    .edgesIgnoringSafeArea(.top)
                    .frame(height: 150)
               
                    Button {
                        shouldShowImagePicker.toggle()
                    } label: {
                        VStack {
                            if let image = self.image {
                                Image(uiImage: image)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 128, height: 128)
                                    .cornerRadius(64)
                            } else {
                                Image(systemName: "person.fill")
                                    .font(.system(size: 64))
                                    .padding()
                                    .foregroundColor(Color("grayi"))
                            }
                        }
                        .overlay(RoundedRectangle(cornerRadius: 64)
                            .stroke(Color.white, lineWidth: 3)
                            .shadow(radius: 40)
                        )
                    }
                    //            Image(uiImage: image )
                    //                .resizable()
                    //                .scaledToFit()
                    //                .frame(width: .infinity, height: .infinity)
                    //                .clipShape(Circle())
                    //                .overlay(Circle()
                    //                    .stroke(Color.white, lineWidth: 4)
                    //                    )
                    //                .shadow(radius: 10)
                    //                .frame(width: 250, height: 250)
                    //
                    //            PhotosPicker(
                    //                       selection: $selectedItem,
                    //                       matching: .images,
                    //                       photoLibrary: .shared()) {
                    //                           Text("Edit")
                    //                               .foregroundColor(Color("pinki"))
                    //
                    //                       }
                    //                       .onChange(of: selectedItem) { newItem in
                    //                           Task {
                    //                               if let data = try? await newItem?.loadTransferable(type: Data.self) {
                    //                                   selectedImageData = data
                    //                               }
                    //                           }
                    //                       }
                    //
                    //                   if let selectedImageData ,
                    //                      let uiImage = UIImage(data: selectedImageData) {
                    //                       Image(uiImage: uiImage)
                    //                           .resizable()
                    //                           .scaledToFit()
                    //                           .frame(width: .infinity, height: .infinity)
                    //                           .clipShape(Circle())
                    //                           .overlay(Circle()
                    //                               .stroke(Color.white, lineWidth: 4)
                    //                               )
                    //                           .shadow(radius: 10)
                    //                           .frame(width: 250, height: 250)
                    //                   }
                }
            }.navigationViewStyle(StackNavigationViewStyle())
                .fullScreenCover(isPresented: $shouldShowImagePicker, onDismiss: nil) {
                    ImagePicker(image: $image)
                        .ignoresSafeArea()
                }
        }
    }


struct ProfileHeader_Previews: PreviewProvider {
    static var previews: some View {
        ProfileHeader()
    }
}
