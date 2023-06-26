//
//  SignOutView.swift
//  GP-OnboardingSign
//
//  Created by Razan Mohammed Alzannan on 27/11/1444 AH.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct SignOutView: View {
    var body: some View {
        VStack{
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
                
            }
        }
    }
}

struct SignOutView_Previews: PreviewProvider {
    static var previews: some View {
        SignOutView()
    }
}
