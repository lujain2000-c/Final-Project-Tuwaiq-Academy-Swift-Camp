//
//  GoogleButtonView.swift
//  GP-OnboardingSign
//
//  Created by Razan Mohammed Alzannan on 26/11/1444 AH.
//

import SwiftUI

struct GoogleButtonView: View {
    var body: some View {
        NavigationLink {
            TabBarView()
        } label: {
            HStack {
                Image("google")
                    .resizable()
                    .frame(width: 25,height: 25)
                    .foregroundColor(.secondary)
                    .padding(.leading, 50.0)
                
                Text("Continue with Google")
                    .font(.title3)
                    .padding(.all)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.gray)
                
                
            }
        }.frame(width:360 ,height: 60).foregroundColor(.gray)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.gray, lineWidth: 1)
                    .frame( maxWidth: 400 ,maxHeight: 50))
    }
}

struct GoogleButtonView_Previews: PreviewProvider {
    static var previews: some View {
        GoogleButtonView()
    }
}
