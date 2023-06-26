//
//  CreateAccountButton.swift
//  GP-OnboardingSign
//
//  Created by Razan Mohammed Alzannan on 28/11/1444 AH.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

struct CreateAccountButton: View {
    @State var email : String = ""
    @State var password : String = ""
    @State private var showingAlert = false
    @State var roles = ["School", "Parent"]
    @State private var selection = "School"
    var body: some View {
        NavigationLink{StartingView()} label :{
            //Auth
            Button("Create Account"){
                if email.isEmpty || password.isEmpty {
                    HapticManager.instance.notification(type: .warning)
                    showingAlert = true
                }
                Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                    if error == nil {
                        print("Created Successfully")
                        HapticManager.instance.notification(type: .success)
                    }else {
                        HapticManager.instance.notification(type: .error)
                        print ("Somthing Wrong !")
                    }
                    
                }
            }
        }
        .foregroundColor(Color.white)
        .font(.custom( "Play-Regular", size: 20))
        .fontWeight(.semibold)
        .frame(maxWidth: .infinity, maxHeight: 50)
        .background(Color("purplei"))
        .cornerRadius(10)
        .padding(.horizontal)
        .padding(.bottom,20)
        .shadow(radius: 4)
    }
}

struct CreateAccountButton_Previews: PreviewProvider {
    static var previews: some View {
        CreateAccountButton()
    }
}
