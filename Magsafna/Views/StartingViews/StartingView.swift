//
//  StartingView.swift
//  GP-OnboardingSign
//
//  Created by Razan Mohammed Alzannan on 26/11/1444 AH.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

// Remaining : validation for password

struct StartingView: View {
    
    @StateObject var vm = DataManager()
    @State var email = ""
    @State var password = ""
    @State var showingSheet = false
   
    @State private var showingAlert = false
    
    var body: some View {
        NavigationStack {
            ZStack{
                Image("Image")
                    .resizable()
                    .ignoresSafeArea()
                
                VStack{
                 
                    
                    VStack(alignment: .leading ) {
                        VStack(alignment: .leading,spacing: 1){
                            Text("Email")
                            
                                .font(.custom( "Play-Regular", size: 24))
                                //.fontWeight(.bold)
                                .foregroundColor(Color("purplei"))
                                .padding()
                            
                            TextField(
                                "Enter your Email",
                                text: $email
                            )
                            .padding()
                                            .autocapitalization(.none)
                                            .keyboardType(.emailAddress)
                                            .disableAutocorrection(true)
                                            .background(Color(.secondarySystemBackground))
                                            .cornerRadius(5.0)
                                            .shadow(radius: 0.7)
                                     
                        }
                        VStack(alignment: .leading,spacing: 1){
                            
                            Text("Password")
                            
                                .font(.custom( "Play-Regular", size: 24))
                                //.fontWeight(.bold)
                                .foregroundColor(Color("purplei"))
                                .padding()
                            
                            SecureField(
                                "Enter your Password",
                                text: $password
                            )
//                           
                            
                            .padding()
                                            .autocapitalization(.none)
                                            .keyboardType(.emailAddress)
                                            .disableAutocorrection(true)
                                            .background(Color(.secondarySystemBackground))
                                            .cornerRadius(5.0)
                                            .shadow(radius: 0.7)
                                 
                        }
                        
                    }.padding(.bottom,80)
                        .padding(.top,136)
                   
                    VStack{
                      
                        NavigationLink(destination: ListenerView().environmentObject(vm)){
                        
                        Button("LogIn"){
                            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                                if  error != nil {
                                    print(error!.localizedDescription)
                                    
                                }
                                
                            }
                            vm.fetchUserType()
                            //showingSheet = true
                            
                        }.foregroundColor(Color.primary)
                            .font(.custom( "Play-Regular", size: 20))
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity, maxHeight: 50)
                            .background(Color("purplei"))
                            .cornerRadius(10)
                            .padding(.horizontal)
                            .padding(.bottom)
                            .shadow(radius: 4)
                    }

                        NavigationLink("Sign Up"){
                            SignUpView()
                        }
                        .foregroundColor(Color.primary)
                        .font(.custom( "Play-Regular", size: 20))
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity,maxHeight: 50)
                        .background(Color("purplei"))
                        .cornerRadius(10)
                        //.padding(.bottom)
                        .shadow(radius: 4)
                        .padding(.horizontal)
                        
                        HStack(alignment: .center){
                                                    Text("Forgot Password?")                .padding(.horizontal,0)
                                                        .padding(.vertical,15)
                                                        .font(.system(size: 15))
                                                        .foregroundColor(Color.gray)
                                                        .multilineTextAlignment(.center)
                                                    NavigationLink(destination: ResetPasswordView()) {
                                                        Text("Click here")
                                                            .font(.system(size: 15))
                                                            .bold()
                                                            .foregroundColor(Color("pinki"))
                                                    }
                                                }.padding(.horizontal, 70)
                        
                    }.padding(.bottom)
                }.padding(.horizontal)
//                    .sheet(isPresented: $showingSheet) {
//                            ListenerView()
//                        .environmentObject(vm)
//                                                    }
                
            }
        }.navigationBarBackButtonHidden(true)
            .tint(.primary)
    }
}
struct StartingView_Previews: PreviewProvider {
    static var previews: some View {
        StartingView()
    }
}
