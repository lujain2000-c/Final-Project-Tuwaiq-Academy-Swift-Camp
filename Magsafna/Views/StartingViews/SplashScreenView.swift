//
//  SplashScreenView.swift
//  GP-OnboardingSign
//
//  Created by Razan Mohammed Alzannan on 25/11/1444 AH.
//

import SwiftUI

struct SplashScreenView: View {
    @State var isActive:Bool = false
    var body: some View {
        VStack {
            if self.isActive {
                OnboardingView()
            } else {
                VStack {
                    ZStack{
                       // Color("glassiprup")
                            //.ignoresSafeArea()
                        
                        VStack {
                            Image("logo")
                                .resizable()
                                .frame(width: 160,height: 160)
                                .cornerRadius(30)
                                .shadow(radius: 7)
                            
                            Text("MAQSAFNA")
                                .font(.custom( "Play-Regular", size: 50))
                                .multilineTextAlignment(.center)
                                .padding()
                        }
                    }
                }
            }
        }
               .onAppear {
                  
                   DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                       
                       withAnimation {
                           self.isActive = true
                       }
                   }
               }
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
