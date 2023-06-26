//
//  SignUpView.swift
//  GP-OnboardingSign
//
//  Created by Razan Mohammed Alzannan on 25/11/1444 AH.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

// Remaining : write name and phone to firebase

struct SignUpView: View {
    
    func isTextFieldsEmpty() -> Bool{
        return (fullName.isEmpty ||  phoneNumber.isEmpty ||  email.isEmpty ||  password.isEmpty || confirmPassword.isEmpty ? true : false)
        }
    
    @StateObject var vm = DataManager()
    var isParent : Bool = true
    @State var fullName : String = ""
    @State var phoneNumber : String = ""
    @State var email : String = ""
    @State var password : String = ""
    @State private var showingAlert = false
    @State var roles = ["School", "Parent"]
    @State private var selection = "school"
    @State private var confirmPassword: String = ""
    @State private var passwordError: String = ""
    @State private var wrongPassword: Float  = 0
    var body: some View {
        NavigationStack {
            VStack{
                VStack(alignment: .leading){
                    Text("Full Name")
                        .font(.custom( "Play-Regular", size: 22))
                        .fontWeight(.bold)
                        .foregroundColor(Color("purplei"))
                        .padding()
                    
                    TextField(
                        "Enter your name",
                        text: $fullName
                    )
                    .padding(.horizontal)
                    .textFieldStyle(.roundedBorder)
                    .font(.system(size: 22))
                    Text("Phone Number")
                        .font(.custom( "Play-Regular", size: 22))
                        .fontWeight(.bold)
                        .foregroundColor(Color("purplei"))
                        .padding()
                    
                    TextField(
                        "Enter your phone number",
                        text: $phoneNumber
                    )
                    .padding(.horizontal)
                    .textFieldStyle(.roundedBorder)
                    .font(.system(size: 22))
                    Text("Email")
                    
                        .font(.custom( "Play-Regular", size: 22))
                        .fontWeight(.bold)
                        .foregroundColor(Color("purplei"))
                    .padding() }
                VStack(alignment: .leading) {
                    TextField(
                        "Enter your email",
                        text: $email
                    )
                    .padding(.horizontal)
                    .textFieldStyle(.roundedBorder)
                    .font(.system(size: 22))
                    Text("Password")
                        .font(.custom( "Play-Regular", size: 22))
                        .fontWeight(.bold)
                        .foregroundColor(Color("purplei"))
                        .padding()
                    
                    SecureField(
                        "Enter your password",
                        text: $password
                    )
                    .padding(.horizontal)
                    .textFieldStyle(.roundedBorder)
                    .font(.system(size: 22))
                    .border(.red, width: CGFloat(wrongPassword))
                    SecureField(
                        "Confirm password",
                        text: $confirmPassword
                    )
                    .padding(.horizontal)
                    .textFieldStyle(.roundedBorder)
                    .font(.system(size: 22))
                    .border(.red, width: CGFloat(wrongPassword))
                    
                    if wrongPassword == 2 {
                                            Text("Password Dosn't match !")
                                                .foregroundColor(.red)
                                        }
//                    HStack {
//                        Text("Your Role")
//                            .font(.custom( "Play-Regular", size: 22))
//                            .fontWeight(.bold)
//                            .foregroundColor(Color("purplei"))
//                            .padding()
//                        Picker("Choose your Role", selection: $selection) {
//                            ForEach(roles, id: \.self) {
//                                Text($0)
//                            }
//                        }
//                        .pickerStyle(.segmented)
//                        .padding(.horizontal)
//                        .padding()
//
//                    }
                    NavigationLink(destination: StartingView()){
                                            Button("Create Account"){

                                                if isTextFieldsEmpty() {
                                                    HapticManager.instance.notification(type: .warning)
                                                    showingAlert = true

                                                }
                                                Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                                                    if error == nil {
                                                        print("Created Successfully")
                                                        HapticManager.instance.notification(type: .success)
                                                    }else {
                                                        HapticManager.instance.notification(type: .error)
                                                        print("Somthing Wrong !")
                                                    }

                                                }
                                                vm.addAllusers(email: email)
                                               
                                                    vm.addParent(fullName: fullName, phoneNumber: phoneNumber)
                                                    //vm.addMaqsaf(schoolName: fullName, phoneNumber: phoneNumber)
                                                
                                                
                                                authenticateUser(password: password, confirmPassword: confirmPassword)


                                            }
                                            .foregroundColor(Color.primary)
                                            .font(.custom( "Play-Regular", size: 20))
                                            .fontWeight(.semibold)
                                            .frame(maxWidth: .infinity, maxHeight: 50)
                                            .background(Color("purplei"))
                                            .cornerRadius(10)
                                            .padding(.horizontal)
                                            .shadow(radius: 4)
                                            .alert("Some Fields are Empty🤨!", isPresented: $showingAlert) {
                                                Button("OK", role: .cancel) { }
                                            }
                        
                        
                    }
                    
                }
                
            }
        }.tint(.primary)
    }
    func isConfiremdPasswored () -> Bool {
            if password == confirmPassword {
                return true
            }
            return false
        }

         func authenticateUser(password: String, confirmPassword: String) {
             if isConfiremdPasswored() {
                 wrongPassword = 0
             } else {
                 wrongPassword = 2
             }
         }

//        func isValidPassword(password: String){
//            if password.count < 6 {
//                passwordError = 0
//            } else {
//                passwordError = 2
//            }
//        }

        func validatePassword(_ password: String) -> Int {
            let capitalLetterRegEx  = ".[A-Z]+."
            let smallLetterRegEx = ".[a-z]+."
            let passwordLengthRegEx = ".{7,}"
            let passwordPredicates = [NSPredicate(format:"SELF MATCHES %@", capitalLetterRegEx),
                                      NSPredicate(format:"SELF MATCHES %@", smallLetterRegEx),
                                      NSPredicate(format:"SELF MATCHES %@", passwordLengthRegEx)]
            let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: passwordPredicates)

            return compoundPredicate.evaluate(with: password) ? 2 : 0
        }
}
struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
