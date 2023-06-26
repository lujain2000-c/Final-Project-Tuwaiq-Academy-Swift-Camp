//
//  OnboardingView.swift
//  GP-OnboardingSign
//
//  Created by Razan Mohammed Alzannan on 25/11/1444 AH.
//

import SwiftUI

struct OnboardingView: View {
    @State private var  currentstep = 0
    var body: some View {
        NavigationStack {
            VStack{
                TabView(selection: $currentstep,  content:  {
                    VStack{
                        Image("Picture31")
                            .resizable()
                            .frame(width: 240, height: 240)
                            .padding(.top,50)
                        
                        Text("With MAQSAFNA App, school canteen sales data are easy to analyze !")
                            .font(.custom( "Play-Regular", size: 21))
                            .multilineTextAlignment(.center)
                            .padding(.top,50)
                            .padding(.horizontal,20)
                    }.tag(0)
                    VStack{
                        Image("Picture29")
                            .resizable()
                            .frame(width: 210, height: 240)
                            .padding(.top,50)
                        
                        Text("Has your child forgotten \nschool fees one day?")
                            .font(.custom( "Play-Regular", size: 21))
                            .multilineTextAlignment(.center)
                            .padding(.top,50)
                            .padding(.horizontal,20)
                        
                    }.tag(1)
                    VStack{
                        Image("Picture21")
                            .resizable()
                            .frame(width: 270, height: 240)
                            .padding(.top,50)
                        
                        Text("Forget Cash!\n Move to Digitalaization!")
                            .font(.custom( "Play-Regular", size: 21))
                            .multilineTextAlignment(.center)
                            .padding(.top,50)
                            .padding(.horizontal,20)
                        
                    }.tag(2)
                    
                }) .tabViewStyle(PageTabViewStyle())
                    .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                NavigationLink("Conteniue"){
                    StartingView()
                }
                .foregroundColor(Color.white)
                .font(.custom( "Play-Regular", size: 19))
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity,maxHeight: 50)
                .background(Color("purplei"))
                .cornerRadius(10)
                .padding(.horizontal)
                .padding(.top)
                .padding(.bottom)

            }
        }.tint(.primary)
    }
    
}
    


struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
