//
//  ResetPasswordView.swift
//  GP-OnboardingSign
//
//  Created by Razan Mohammed Alzannan on 27/11/1444 AH.
//

import SwiftUI
import Firebase

struct ResetPasswordView: View {
    
    @State private var email = ""
    @State private var alertMessage = ""
    @State private var showAlert = false
    
    var body: some View {
        VStack {
            Text("Reset Password")
                .font(.custom( "Play-Regular", size: 35))
                .fontWeight(.bold)
            
            TextField("Enter your email", text: $email)
                .padding()
                .autocapitalization(.none)
                .keyboardType(.emailAddress)
                .disableAutocorrection(true)
                .background(Color(.secondarySystemBackground))
                .cornerRadius(5.0)
            
            Button(action: {
                Auth.auth().sendPasswordReset(withEmail: email) { error in
                    if let error = error {
                        alertMessage = error.localizedDescription
                        showAlert = true
                    } else {
                        alertMessage = "Reset instructions sent to your email."
                        showAlert = true
                    }
                }
            })
            {
                Text("Reset Password")
                    .foregroundColor(Color.white)
                    .font(.custom( "Play-Regular", size: 20))
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, maxHeight: 50)
                    .background(Color("purplei"))
                    .cornerRadius(10)

                    .padding(.bottom,20)
                    .shadow(radius: 4)
            }
            .padding(.top, 20)
            .alert(isPresented: $showAlert) {
                Alert(title: Text(alertMessage))
            }
        }
        .padding()
    }
}

struct ResetPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ResetPasswordView()
    }
}
